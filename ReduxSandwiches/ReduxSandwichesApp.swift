//
//  ReduxSandwichesApp.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-15.
//

import SwiftUI

func initializedStore() -> AppStore {
    let theStore = AppStore(initialState: .defaultState,
                            reducer: appReducer,
                            middleware: [createLoggerMiddleware(),
                                         createSandwichMiddleware(for: SandwichService.live)
                                         ])

    theStore.dispatch(.sandwich(action: .retrieveSandwich(excluding: "")))
    
    return theStore
}

@main
struct ReduxSandwichesApp: App {
    @StateObject private var store: AppStore = initializedStore()
    
    var body: some Scene {
        WindowGroup {
            MainMenuView()
                .environmentObject(store)
        }
    }
}
