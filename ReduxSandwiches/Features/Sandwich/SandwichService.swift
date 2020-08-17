//
//  SandwichService.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-09.
//

import Foundation

struct SandwichService {
    var fetchSandwich: (@escaping (Result<String,Error>) -> Void) -> Void
}

// Live Service
extension SandwichService {

    static let sandwiches =
        [
        "Club",
        "Pastrami on rye",
        "French dip",
        "Banh mi",
        "Ice Cream Sandwich",
        "Croque madame",
        "Hot dog",
        "Fluffernutter",
        "Avocado Toast",
        "Gua bao"
        ]
    
    static let live = SandwichService(fetchSandwich: { completion in
        let waitTime = 2.0 // Double.random(in: 0..<5)
        
        let errorOccured = false //Int.random(in: 1...10) == 1 ? true : false
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + waitTime) {
            
            guard !errorOccured else {
                completion(.failure(SandwichServiceError.general))
                return
            }
            
            let chosenSandwich = Self.sandwiches.randomElement() ?? ""
            completion(.success(chosenSandwich))
        }
    })
}

enum SandwichServiceError: Error {
    case general
}
