//
//  LoggingCardService.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 12/11/2023.
//

import Foundation

final class LoggingCardService: CardService {
   
    private let cardService: CardService

    init(cardService: CardService) {
        self.cardService = cardService
    }

    func apply(_ cardNumber: CardNumber, _ operation: (Card) -> CardTransaction?) throws {
        print("Executing operation on card number \(cardNumber.description)")
        try cardService.apply(cardNumber, operation)
    }

    func getBalance(_ cardNumber: CardNumber) throws -> MonetaryAmount {
        print("Executing balance request on card number \(cardNumber.description)")
        return try cardService.getBalance(cardNumber)
    }
    
}
