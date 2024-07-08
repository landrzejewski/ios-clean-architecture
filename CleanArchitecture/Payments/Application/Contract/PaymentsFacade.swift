//
//  PaymentsFacade.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

final class PaymentsFacade: Payments {

    private var cards: Cards
    private var operations: Operations
    private var transactions: Transactions

    init(cards: Cards, operations: Operations, transactions: Transactions) {
        self.cards = cards
        self.operations = operations
        self.transactions = transactions
    }

    func getBalance(_ cardNumber: CardNumber) throws -> MonetaryAmount {
        try cards.getBalance(forCard: cardNumber)
    }

    func getTransactionsSince(_ cardNumber: CardNumber, _ timestamp: Date) throws -> [CardTransaction] {
        try transactions.getTransactionsSince(cardNumber: cardNumber, timestamp: timestamp)
    }

    func chargePayment(_ cardNumber: CardNumber, _ value: MonetaryAmount) throws {
        try operations.chargePayment(cardNumber: cardNumber, value: value)
    }

    func chargeFees(_ cardNumber: CardNumber) throws {
        try operations.chargeFees(cardNumber: cardNumber)
    }
    
}
