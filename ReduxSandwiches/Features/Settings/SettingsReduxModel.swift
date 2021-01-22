//
//  SettingsActions.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-12.
//

import Foundation
import SwiftUI

enum SettingsAction {
    case setAppearanceMode(to: AppearanceMode)
}

enum AppearanceMode: String, CaseIterable {
    case dark
    case light
    case system
}

struct SettingsState {
    var appearanceMode: AppearanceMode
}

func settingsReducer(state: inout SettingsState, action: SettingsAction) -> Void {
    
    switch action {
    case .setAppearanceMode(let mode):
        state.appearanceMode = mode
    }
}


