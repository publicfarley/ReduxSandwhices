//
//  LogMiddleware.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-09.
//

import Foundation

func createLoggerMiddleware() -> Middleware<AppState,AppAction> {
    let separator = "----"
    
    return { state, action, _ in
        print(separator)
        print("\(Date())")
        print("\(action)")
        print("\(state)")
        print(separator)
    }
}
