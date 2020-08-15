//
//  Common.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-09.
//

import Foundation

enum DataStatus<Value,Error> {
    case empty
    case loading
    case loaded(value: Value)
    case error(Error)
}

extension DataStatus: CustomStringConvertible {
    var description: String {
        let prefix = "Data Status for \(Value.self)"
        let suffix: String
        
        switch self {
        case .empty:
            suffix = "empty"
        case .loading:
            suffix = "loading"
        case .loaded(let value):
            suffix = "loaded: \(value)"
        case .error(let error):
            suffix = "error: \(error)"
        }
        
        return "\(prefix) \(suffix)"
    }
}
