//
//  MainMenuReduxModel.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-12.
//

import Foundation

enum MainMenuAction {
    case setCurrentScreen(to: ScreenState)
}

enum ScreenState: Int {
    case sandwichDisplay
    case settingsDisplay
    case aboutDisplay
}

func mainMenuNavigationReducer(screenState: inout ScreenState,
                                    action: MainMenuAction) -> Void {
    
    switch action {
    case .setCurrentScreen(let newScreenState):
        screenState = newScreenState
    }
}
