//
//  SandwichView.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-08.
//

import SwiftUI

struct SandwichView: View {
    @EnvironmentObject var store: AppStore
    
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
                        loadSandwich()
                    }

                default:
                    EmptyView()
                }
                
                Spacer()
            }
        }
        .alert(isPresented: .constant(isError())) {
            Alert(title: Text("Error loading sandwich"), message: Text(""), primaryButton: .default(Text("Try Again"), action: loadSandwich), secondaryButton: .cancel(resetToEmpty))
        }
    }
    
    private func isError() -> Bool {
        guard store.state.screenState == .sandwichDisplay else {
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
        
    private func loadSandwich() {
        store.dispatch(.sandwich(action: .retrieveCurrentSandwich))
    }
    
    private func resetToEmpty() {
        store.dispatch(.sandwich(action: .setCurrentSandwich(sandwich: .success(""))))
    }
    
    private var sandwichState: SandwichState {
        store.state.sandwichState
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
