//
//  MainSandwichView.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-16.
//

import SwiftUI

struct MainSandwichView: View {
    @EnvironmentObject private var store: AppStore
    
    var viewModel: SandwichViewModel {
        store as SandwichViewModel
    }
    
    @State var isSandwichPresented = false  // Required to track the observed store, so that the zoom transition insertion animation works
    
    var body: some View {
        VStack {
            Text("Sandwiches")
                .bold()
                .font(.largeTitle)
            
            Spacer()
            
            VStack {
                Spacer()
                
                currentSandwichView
                    .padding()

                switch viewModel.sandwichState.status {
                case .loaded, .empty:
                    Button("Load New Sandwich") {
                        withAnimation {
                            isSandwichPresented = false
                            viewModel.retrieveNewSandwich()
                        }
                    }

                default:
                    EmptyView()
                }
                
                Spacer()
                
                HStack { Spacer() }
                // HStack is needed for the transition to work correctly (as per here: https://stackoverflow.com/questions/56680017/this-swiftui-animation-should-only-fade-out-why-does-it-move-to-the-right)
            }
        }
        .alert(isPresented: .constant(isError())) {
            Alert(title: Text("Error loading sandwich"), message: Text(""), primaryButton: .default(Text("Try Again"), action: viewModel.retrieveNewSandwich), secondaryButton: .cancel(viewModel.clearCurrentSandwich))
        }
    }
    
    private func isError() -> Bool {
        guard viewModel.isSandwichViewTheCurrentView else {
            return false
        }
        
        switch viewModel.sandwichState.status {
        case .error:
            return true
        default:
            return false
        }
    }
    
    private var currentSandwichView: some View {
        VStack {
            switch viewModel.sandwichState.status {
            case .empty, .error:
                EmptyView()

            case .loading:
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .foregroundColor(.blue)

            case .loaded(let currentSandwich):
                VStack {
                    if isSandwichPresented {
                        VStack {
                        Image(currentSandwich)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 250, height: 250)
                            .padding()
                        
                        Text(currentSandwich)
                            .font(.title)
                        }
                        .transition(.scale)

                    } else {
                        Text("") // Required so that the zoom transition animation works correctly for current sandwich view insertion
                            .frame(width: 250, height: 250)
                            .padding()
                    }

                }
                .transition(.scale)
                .onAppear {
                    withAnimation {
                        isSandwichPresented = true
                    }
                }
            }
        }
    }
}

struct MainSandwichView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Coming Soon")//MainSandwichView()
    }
}
