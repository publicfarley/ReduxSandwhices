//
//  AppReducers.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-08.
//

import Foundation

typealias Reducer<State,Action> = (inout State, Action) -> Void

func appReducer(state: inout AppState, action: AppAction) -> Void {
    
    switch action {
    
    case .sandwich(let sandwichAction):
        sandwichReducer(state: &state.sandwichState, action: sandwichAction)
    
    case .navigation(let navigationAction):
        mainMenuNavigationReducer(screenState: &state.screenState,
                                       action: navigationAction)
    
    case .settings(let settingsAction):
        settingsReducer(state: &state.settingsState,
                        action: settingsAction)
    }
}


