//
//  SandwichService.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-09.
//

import Foundation

struct SandwichService {
    var fetchSandwich: (SandwichName, @escaping (Result<SandwichName,Error>) -> Void) -> Void
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
        "Italian Sausage",
        "Egg Salad",
        "Smoked Salmon Eggs Benedict",
        "Tuna Salad",
        "Eggplant Parmesan"
        ]
    
    static let live = SandwichService(fetchSandwich: { excludedSandwich, completion in
        let waitTime = 2.0 // Double.random(in: 0..<5)
        
        let errorOccured = false //Int.random(in: 1...10) == 1 ? true : false
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + waitTime) {
            
            guard !errorOccured else {
                completion(.failure(SandwichServiceError.general))
                return
            }
            
            let sandwichesToChooseFrom = Self.sandwiches.filter { $0 != excludedSandwich }
            let chosenSandwich = sandwichesToChooseFrom.randomElement() ?? ""
            completion(.success(chosenSandwich))
        }
    })
}

enum SandwichServiceError: Error {
    case general
}
