//
//  Card.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 12/11/2023.
//

import Foundation

final class Card {
    
    private let number: CardNumber
    private let expirationDate: Date
    
    private var transactions: [CardTransaction]
    private var eventListeners: [(TransactionAddedEvent) -> ()] = []
    private var balance: MonetaryAmount
    
    var getNumber: CardNumber {
        number
    }
    
    var getExpirationDate: Date {
        expirationDate
    }

    var getTransactions: [CardTransaction] {
        transactions
    }

    var getBalance: MonetaryAmount {
         balance
    }

    init(number: CardNumber, expirationDate: Date, balance: MonetaryAmount, transactions: [CardTransaction]) {
        self.number = number
        self.expirationDate = expirationDate
        self.balance = balance
        self.transactions = transactions
    }

    func add(_ transaction: CardTransaction) throws {
        try validate(transaction)
        try register(transaction)
        publish(transaction)
    }

    private func validate(_ transaction: CardTransaction) throws {
        try TransactionTimeSpecification.check(transaction, expirationDate)
        try TransactionAmountSpecification.check(transaction, balance)
    }

    private func register(_ transaction: CardTransaction) throws {
        transactions.insert(transaction, at: 0)
        switch transaction.type {
        case .fee, .payment:
            balance = try balance.subtract(transaction.amount)
        }
    }

    private func publish(_ transaction: CardTransaction) {
        let transactionAddedEvent = TransactionAddedEvent(cardNumber: number, cardTransaction: transaction)
        eventListeners.forEach { listener in
            listener(transactionAddedEvent)
        }
    }

    func addEventListener(_ listener: @escaping (TransactionAddedEvent) -> ()) {
        eventListeners.append(listener)
    }
    
    func copy() -> Card {
        Card(number: number, expirationDate: expirationDate, balance: balance, transactions: transactions)
    }
    
}
