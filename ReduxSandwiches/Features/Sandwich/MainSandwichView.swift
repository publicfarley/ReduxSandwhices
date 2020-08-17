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
                    .transition(AnyTransition.scale.animation(.easeInOut(duration: 0.25)))

                switch viewModel.sandwichState.status {
                case .loaded, .empty:
                    Button("Load New Sandwich") {
                        viewModel.retrieveCurrentSandwich()
                    }

                default:
                    EmptyView()
                }
                
                Spacer()
            }
        }
        .alert(isPresented: .constant(isError())) {
            Alert(title: Text("Error loading sandwich"), message: Text(""), primaryButton: .default(Text("Try Again"), action: viewModel.retrieveCurrentSandwich), secondaryButton: .cancel(viewModel.clearCurrentSandwich))
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
        Group {
            switch viewModel.sandwichState.status {
            case .empty:
                EmptyView()
                
            case .loading:
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .foregroundColor(.blue)
                
            case .loaded(let currentSandwich):
                VStack {
                    Image(currentSandwich)
                        .resizable()
                        .frame(width: 250, height: 250)
                        .clipShape(Circle())
                        .padding()

                    Text(currentSandwich)
                        .font(.title)
                }
                
            case .error:
                EmptyView()
            }
        }
    }
}

struct MainSandwichView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Coming Soon")//MainSandwichView()
    }
}
