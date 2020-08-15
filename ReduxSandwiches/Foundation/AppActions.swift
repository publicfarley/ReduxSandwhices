//
//  AppActions.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-08.
//

import Foundation

enum AppAction {
    case navigation(action: MainMenuAction)
    case sandwich(action: SandwichAction)
    case settings(action: SettingsAction)
}

