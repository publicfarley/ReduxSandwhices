//
//  AppStore.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-08.
//

import Foundation

typealias Dispatcher<Action> = (Action) -> Void
typealias Middleware<State,Action> = (State,Action, @escaping Dispatcher<Action>) -> Void
typealias AppStore = Store<AppState,AppAction>

final class Store<State,Action>: ObservableObject {
    @Published private(set) var state: State
    
    private let reducer: Reducer<State, Action>
    private let middleware: [Middleware<State,Action>]
    
    init(initialState: State,
         reducer: @escaping Reducer<State,Action>,
         middleware: [Middleware<State,Action>]) {
        
        self.state = initialState
        self.reducer = reducer
        self.middleware = middleware
    }
    
    func dispatch(_ action: Action) {
        reducer(&state,action)
        
        middleware.forEach { middlewareInstance in
            middlewareInstance(state, action, dispatch)
        }
    }
}
