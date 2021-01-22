//
//  AppState.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-08.
//

import Foundation

struct AppState {
    var screenState: ScreenState
    
    var sandwichState: SandwichState
    var settingsState: SettingsState
    var aboutState: AboutState
}


extension AppState {
    static let defaultState = AppState(screenState: .sandwichDisplay,
                                sandwichState: SandwichState(status: .empty),
                                settingsState: SettingsState(appearanceMode: .system),
                                aboutState: AboutState())
}

extension AppState: CustomStringConvertible {
    var description: String {
"""
AppState
SandwichState: \(sandwichState)
ScreenState: \(screenState)
SettingsState: \(settingsState)
"""
    }
}
