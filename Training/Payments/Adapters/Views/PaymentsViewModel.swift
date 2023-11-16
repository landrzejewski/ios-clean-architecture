//
//  PaymentsViewModel.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 13/11/2023.
//

import Foundation

final class PaymentsViewModel: ObservableObject {
    
    private let paymentsConfiguration: PaymentsConfiguration
    
    init(paymentsConfiguration: PaymentsConfiguration) {
        self.paymentsConfiguration = paymentsConfiguration
    }
    
    func start() throws {
        // Configuration
        let idGenerator = paymentsConfiguration.idGenerator()
        let timeProvider = paymentsConfiguration.timeProvider()
        let cardRepository = paymentsConfiguration.cardRepository()
        let cardEventsPublisher = paymentsConfiguration.cardEventsPublisher()
        let transactionFeePolicy = paymentsConfiguration.transactionFeePolicy()
        let cardFeesCalculator = paymentsConfiguration.cardFeesCalculator(transactionFeePolicy: transactionFeePolicy)
        let cardService = paymentsConfiguration.cardService(cardRepository: cardRepository)
        let transactionService = paymentsConfiguration.transactionService(cardRepository: cardRepository, idGenerator: idGenerator, timeProvider: timeProvider)
        let chargeService = paymentsConfiguration.chargeService(cardService: cardService, cardEventsPublisher: cardEventsPublisher, cardFeesCalculator: cardFeesCalculator, transactionService: transactionService)
        let cards = paymentsConfiguration.cardsFacade(cardService: cardService, transactionService: transactionService, chargeService: chargeService)
        
        // Data initialization
        let yesterday = Date().addingTimeInterval(-24 * 60 * 60)
        let currency = MonetaryAmount.defaultCurrency
        let cardNumber = try CardNumber(value: "1234567890123456")!
        let cardBalance: Double = 10_000
        let cardExpirationDate = Date().addingTimeInterval(365 * 24 * 60 * 60)
        
        let card = Card(number: cardNumber, expirationDate: cardExpirationDate, balance: MonetaryAmount(value: cardBalance, currency: currency), transactions: [])
        cardRepository.save(card: card)
        
        // Operations
        try cards.chargePayment(cardNumber, MonetaryAmount(value: 10, currency: currency))
        try cards.chargePayment(cardNumber, MonetaryAmount(value: 20, currency: currency))
        try cards.chargeFees(cardNumber)
        try cards.chargePayment(cardNumber, MonetaryAmount(value: 15, currency: currency))
        
        print("Transactions on card number \(cardNumber.description):")
        let transactions = try cards.getTransactionsSince(cardNumber, yesterday)
        transactions.forEach { transaction in
            print(transaction.description)
        }
        
        print("Card balance: \(try cards.getBalance(cardNumber).description)")
    }
    
}
