//
//  Operations.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

final class Operations {
    
    private let cards: Cards
    private let feesCalculator: CardFeesCalculator
    private let transactions: Transactions
    private let eventsPublisher: CardEventsPublisher
    
    init(cards: Cards, feesCalculator: CardFeesCalculator, transactions: Transactions, eventsPublisher: CardEventsPublisher) {
        self.cards = cards
        self.feesCalculator = feesCalculator
        self.transactions = transactions
        self.eventsPublisher = eventsPublisher
    }
    
    func chargePayment(cardNumber: CardNumber, value: MonetaryAmount) throws {
        try cards.apply(cardNumber) { card in
            card.addEventListener(self.publishEvents)
            return transactions.createTransaction(value: value, type: .payment)
        }
    }
    
    func chargeFees(cardNumber: CardNumber) throws {
        try cards.apply(cardNumber) { card in
            let feesValue = self.feesCalculator.calculate(card.getTransactions)
            if feesValue.isGreaterThanZero() {
                return self.transactions.createTransaction(value: feesValue, type: .fee)
            } else {
                return nil
            }
        }
    }
    
    private func publishEvents(_ transactionAddedEvent: TransactionAddedEvent) {
        let cardNumber = transactionAddedEvent.cardNumber
        let cardChargedEvent = CardChargedEvend(cardNumber: cardNumber)
        eventsPublisher.publish(event: cardChargedEvent)
    }
    
}
