//
//  SandwichReduxModel.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-14.
//

import Foundation

// MARK: State
typealias SandwichName = String

struct SandwichState {
    var status: DataStatus<SandwichName,Error>
}

// MARK: Actions
enum SandwichAction {
    case retrieveSandwich(excluding: SandwichName)
    case setCurrentSandwich(sandwich: Result<SandwichName,Error>)
}

// MARK: Reducers
func sandwichReducer(state: inout SandwichState, action: SandwichAction) -> Void {
    
    switch action {
    
    case .setCurrentSandwich(let result):
        switch result {
            case .success(let sandwich):
                state.status = sandwich == "" ? .empty : .loaded(value: sandwich)
            
            case .failure(let error):
                state.status = .error(error)
        }
        
        
    case .retrieveSandwich:
        state.status = .loading
    }
}


extension SandwichState: CustomStringConvertible {
    var description: String {
        "\(status)"
    }
}

extension SandwichAction: CustomStringConvertible {
    var description: String {
        let prefix = "SandwichAction:"
        let suffix: String
        
        switch self {
        case .retrieveSandwich(let excludedSandwich):
            suffix = "retrieveSandwich excluding \(excludedSandwich == "" ? "none" : excludedSandwich)"
        case .setCurrentSandwich(let sandwich):
            suffix = "setCurrentSandwich to result: \(sandwich)"
        }
        
        return "\(prefix) \(suffix)"
    }
}

