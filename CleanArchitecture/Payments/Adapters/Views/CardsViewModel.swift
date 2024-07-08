//
//  CardsViewModel.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

@Observable
final class CardsViewModel {
    
    private let container: PaymentsConfiguration
    
    init(container: PaymentsConfiguration) {
        self.container = container
    }
    
    func start() throws {
        // Configuration
        let idGenerator = container.idGenerator()
        let timeProvider = container.timeProvider()
        let cardRepository = container.cardRepository()
        let eventsPublisher = container.cardEventsPublisher()
        let transactionFeePolicy = container.transactionFeePolicy()
        let feesCalculator = container.cardFeesCalculator(transactionFeePolicy: transactionFeePolicy)
        let cards = container.cards(cardRepository: cardRepository)
        let transactions = container.transactions(cardRepository: cardRepository, idGenerator: idGenerator, timeProvider: timeProvider)
        let operations = container.operations(cards: cards, feesCalculator: feesCalculator, trasactions: transactions, eventsPublisher: eventsPublisher)
        
        // Data initialization
        let yesterday = Date().addingTimeInterval(-24 * 60 * 60)
        let currency = Currency(code: "EUR")
        let cardNumber = try CardNumber(value: "1234567890123456")!
        let cardBalance: Double = 10_000
        let cardExpirationDate = Date().addingTimeInterval(365 * 24 * 60 * 60)
        
        let card = Card(number: cardNumber, expirationDate: cardExpirationDate, balance: MonetaryAmount(value: cardBalance, currency: currency), transactions: [])
        cardRepository.save(card: card)
        
        // Operations
        try operations.chargePayment(cardNumber: cardNumber, value: MonetaryAmount(value: 10, currency: currency))
        try operations.chargePayment(cardNumber: cardNumber, value: MonetaryAmount(value: 20, currency: currency))
        try operations.chargeFees(cardNumber: cardNumber)
        try operations.chargePayment(cardNumber: cardNumber, value: MonetaryAmount(value: 15, currency: currency))
        
        print("Transactions on card number \(cardNumber.description):")
        let cardTransactions = try transactions.getTransactionsSince(cardNumber: cardNumber, timestamp: yesterday)
        cardTransactions.forEach { transaction in
            print(transaction.description)
        }
        
        print("Card balance: \(try cards.getBalance(forCard: cardNumber).description)")
    }
    
}
