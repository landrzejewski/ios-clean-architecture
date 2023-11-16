//
//  ChargeService.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 12/11/2023.
//

import Foundation

final class ChargeService {
    
    private let cardService: CardService
    private let cardEventsPublisher: CardEventsPublisher
    private let feesCalculator: CardFeesCalculator
    private let transactionService: TransactionService

    init(cardService: CardService, cardEventsPublisher: CardEventsPublisher, feesCalculator: CardFeesCalculator, transactionService: TransactionService) {
        self.cardService = cardService
        self.cardEventsPublisher = cardEventsPublisher
        self.feesCalculator = feesCalculator
        self.transactionService = transactionService
    }

    func chargePayment(cardNumber: CardNumber, value: MonetaryAmount) throws {
        try cardService.apply(cardNumber) { card in
            card.addEventListener(self.publishEvents)
            return transactionService.createTransaction(value: value, type: .payment)
        }
    }

    func chargeFees(cardNumber: CardNumber) throws {
        try cardService.apply(cardNumber) { (card: Card) in
            let fees = self.feesCalculator.calculate(card.getTransactions)
            if fees.isGreaterThanZero() {
                return self.transactionService.createTransaction(value: fees, type: .fee)
            } else {
                return nil
            }
        }
    }

    private func publishEvents(_ transactionAddedEvent: TransactionAddedEvent) {
        let cardNumber = transactionAddedEvent.cardNumber
        let applicationEvent = CardChargedEvent(cardNumber: cardNumber)
        cardEventsPublisher.publish(event: applicationEvent)
    }
    
}
