//
//  SandwichMiddleware.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-09.
//

import Foundation

func createSandwichMiddleware(for service: SandwichService) -> Middleware<AppState, AppAction> {
    
    return { _,action,dispatcher in
        
        switch action {
        
        case .sandwich(.retrieveCurrentSandwich):
            
            service.fetchSandwich { result in
                DispatchQueue.main.async {
                    dispatcher(AppAction.sandwich(action: .setCurrentSandwich(sandwich: result)))
                }
            }

        default:
            break
        }
    }
}
