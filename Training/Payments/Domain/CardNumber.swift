//
//  CardNumber.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 12/11/2023.
//

import Foundation

struct CardNumber: Hashable {
    
    let value: String
    
    var description: String {
        value
    }
    
    init?(value: String) throws {
        try check(value, regex: "\\d{16,19}", error: PaymentsErrors.invalidCardNumber)
        self.value = value
    }
    
}
