//
//  SandwichViewModel.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-15.
//

import Foundation

protocol SandwichViewModel {
    var sandwichState: SandwichState { get }
    var isSandwichViewTheCurrentView: Bool { get }
    var currentSandwich: SandwichName { get }
    func retrieveNewSandwich()
    func clearCurrentSandwich()
}

extension AppStore: SandwichViewModel {
    var sandwichState: SandwichState {
        state.sandwichState
    }
    
    var isSandwichViewTheCurrentView: Bool {
        state.screenState == .sandwichDisplay
    }

    var currentSandwich: SandwichName {
        switch state.sandwichState.status {
        case .loaded(value: let value):
            return value
        default:
            return ""
        }
    }

    func retrieveNewSandwich() {
        dispatch(.sandwich(action: .retrieveSandwich(excluding: currentSandwich)))
    }
    
    func clearCurrentSandwich() {
        dispatch(.sandwich(action: .setCurrentSandwich(sandwich: .success(""))))
    }
    
}
