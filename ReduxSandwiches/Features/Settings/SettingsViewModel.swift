//
//  SettingsViewModel.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-16.
//

import Foundation

protocol SettingsViewModel {
    var currentAppearanceMode: AppearanceMode { get }
    func setAppearanceMode(to appearanceMode: AppearanceMode)
}

extension AppStore: SettingsViewModel {
    var currentAppearanceMode: AppearanceMode {
        state.settingsState.appearanceMode
    }
    
    func setAppearanceMode(to appearanceMode: AppearanceMode) {
        dispatch(.settings(action: .setAppearanceMode(to: appearanceMode)))
    }
}
