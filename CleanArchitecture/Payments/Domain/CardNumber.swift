//
//  CardNumber.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

struct CardNumber: Hashable {
    
    let value: String
    
    var description: String {
        value
    }
    
    init?(value: String) throws {
        try check(value, regex: "\\d{16,19}", error: DomainErrors.invalidCardNumber)
        self.value = value
    }
    
}
