//
//  SandwichService.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-09.
//

import Foundation

struct SandwichService {
    static let sandwichs = [
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
    
    func fetchSandwich(completion: @escaping (Result<String,Error>) -> Void) {
        let waitTime = Double.random(in: 0..<5)
        
        let errorOccured = Int.random(in: 1...10) == 1 ? true : false // 33% chance of error
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + waitTime) {
            
            guard !errorOccured else {
                completion(.failure(SandwichServiceError.general))
                return
            }
            
            let chosenSandwich = Self.sandwichs.randomElement() ?? ""
            completion(.success(chosenSandwich))
        }
    }
}

enum SandwichServiceError: Error {
    case general
}
