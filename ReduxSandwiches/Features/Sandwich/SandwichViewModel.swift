//
//  SandwichViewModel.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-15.
//

import Foundation

protocol SandwichViewModel {
    var sandwichState: SandwichState { get }
    var isCurrentView: Bool { get }
    func retrieveCurrentSandwich()
    func clearCurrentSandwich()
}

extension AppStore: SandwichViewModel {
    var sandwichState: SandwichState {
        state.sandwichState
    }
    
    var isCurrentView: Bool {
        state.screenState == .sandwichDisplay
    }
    
    func retrieveCurrentSandwich() {
        dispatch(.sandwich(action: .retrieveCurrentSandwich))
    }
    
    func clearCurrentSandwich() {
        dispatch(.sandwich(action: .setCurrentSandwich(sandwich: .success(""))))
 
    }
}