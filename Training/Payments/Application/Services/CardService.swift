//
//  CardService.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 12/11/2023.
//

import Foundation

protocol CardService {
    
    func apply(_ cardNumber: CardNumber, _ operation: (Card) -> CardTransaction?) throws
    
    func getBalance(_ cardNumber: CardNumber) throws -> MonetaryAmount
    
}
