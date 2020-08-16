//
//  SandwichView.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-08.
//

import SwiftUI

struct SandwichView: View {
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

                switch sandwichState.status {
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
        
        switch sandwichState.status {
        case .error:
            return true
        default:
            return false
        }
    }
    
    private var currentSandwichView: some View {
        Group {
            switch sandwichState.status {
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
        
    private var sandwichState: SandwichState {
        viewModel.sandwichState
    }
}


// MARK: SwiftUI Previews
struct SandwichView_Previews_Loading: PreviewProvider {
    static var previews: some View {
        SandwichView()
            .environmentObject(initializedStore())
    }
}

struct SandwichView_Previews_Loaded: PreviewProvider {
    
    static func initializedStore() -> AppStore {
        let theStore = AppStore(
            initialState: .defaultState,
            reducer: appReducer,
            middleware:[])
        
        theStore.dispatch(.sandwich(action: .setCurrentSandwich(sandwich: .success("Test Sandwich"))))
        
        return theStore
    }
    
    static var previews: some View {
        SandwichView()
            .environmentObject(Self.initializedStore())
    }
}


struct SandwichView_Previews_Empty: PreviewProvider {
    
    static func initializedStore() -> AppStore {
        let theStore = AppStore(
            initialState: .defaultState,
            reducer: appReducer,
            middleware:[])
        
        theStore.dispatch(.sandwich(action: .setCurrentSandwich(sandwich: .success(""))))

        return theStore
    }
    
    static var previews: some View {
        SandwichView()
            .environmentObject(Self.initializedStore())
    }
}
