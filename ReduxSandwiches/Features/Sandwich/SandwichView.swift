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
    
    @State private var isZoomed = false
    
    var body: some View {
        VStack {
            if isZoomed {
                ZoomedSandwichView(sandwich: viewModel.currentSandwich)
            } else {
                MainSandwichView()
            }
        }
        .contentShape(Rectangle()) // Makes the whole VStack tappable, rather than just the constituent content items
        .onTapGesture {
            withAnimation {
                if !viewModel.currentSandwich.isEmpty {
                    isZoomed.toggle()
                }
            }
        }
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
        
        theStore.dispatch(.sandwich(action: .setCurrentSandwich(sandwich: .success("Avocado Toast"))))
        
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
