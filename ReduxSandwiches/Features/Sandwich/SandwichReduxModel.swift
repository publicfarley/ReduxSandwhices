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

extension SandwichState: CustomStringConvertible {
    var description: String {
        "\(status)"
    }
}

// MARK: Actions
enum SandwichAction {
    case retrieveCurrentSandwich
    case setCurrentSandwich(sandwich: Result<String,Error>)
}

extension SandwichAction: CustomStringConvertible {
    var description: String {
        let prefix = "SandwichAction:"
        let suffix: String
        
        switch self {
        case .retrieveCurrentSandwich:
            suffix = "retrieveCurrentSandwich"
        case .setCurrentSandwich(let sandwich):
            suffix = "setCurrentSandwich to result: \(sandwich)"
        }
        
        return "\(prefix) \(suffix)"
    }
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
        
        
    case .retrieveCurrentSandwich:
        state.status = .loading
    }
}


