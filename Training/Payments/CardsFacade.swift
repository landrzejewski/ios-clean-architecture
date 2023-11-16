//
//  CardsFacade.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 12/11/2023.
//

import Foundation

final class CardsFacade {

    private var cardService: CardService
    private var chargeService: ChargeService
    private var transactionService: TransactionService

    init(cardService: CardService, transactionService: TransactionService, chargeService: ChargeService) {
        self.cardService = cardService
        self.transactionService = transactionService
        self.chargeService = chargeService
    }

    func getBalance(_ cardNumber: CardNumber) throws -> MonetaryAmount {
        try cardService.getBalance(cardNumber)
    }

    func getTransactionsSince(_ cardNumber: CardNumber, _ timestamp: Date) throws -> [CardTransaction] {
        try transactionService.getTransactionsSince(cardNumber: cardNumber, timestamp: timestamp)
    }

    func chargePayment(_ cardNumber: CardNumber, _ value: MonetaryAmount) throws {
        try chargeService.chargePayment(cardNumber: cardNumber, value: value)
    }

    func chargeFees(_ cardNumber: CardNumber) throws {
        try chargeService.chargeFees(cardNumber: cardNumber)
    }
    
}
