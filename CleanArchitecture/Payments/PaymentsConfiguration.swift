//
//  PaymentsConfiguration.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

final class PaymentsConfiguration {
    
    private let inMemoryCardRepository = InMemoryCardRepository()
    private let incrementalIdGenerator = IncrementalIdGenerator()
    
    init() throws {
        // Data initialization
        let currency = Currency(code: "EUR")
        let cardNumber = try CardNumber(value: "1234567890123456")!
        let cardBalance: Double = 10_000
        let cardExpirationDate = Date().addingTimeInterval(365 * 24 * 60 * 60)
        let card = Card(number: cardNumber, expirationDate: cardExpirationDate, balance: MonetaryAmount(value: cardBalance, currency: currency), transactions: [])
        cardRepository().save(card: card)
 
    }
    
    private func idGenerator() -> IdGenerator {
        incrementalIdGenerator
    }

    private func timeProvider() -> TimeProvider {
        SystemTimeProvider()
    }

    private func cardRepository() -> CardRepository {
        inMemoryCardRepository
    }

    private func cardEventsPublisher() -> CardEventsPublisher {
        ConsoleCardEventsPublisher()
    }

    private func transactionFeePolicy() -> TransactionFeePolicy {
        PerTransactionFeePolicy(singleTransactionFee: MonetaryAmount(value: 1, currency: Currency(code: "EUR")))
    }

    private func cardFeesCalculator(transactionFeePolicy: TransactionFeePolicy) -> CardFeesCalculator {
        CardFeesCalculator(transactionFeePolicy: transactionFeePolicy)
    }

    private func cards() -> Cards {
        return Cards(cardRepository: cardRepository())
    }

    private func transactions() -> Transactions {
        Transactions(cardRepository: cardRepository(), idGenerator: idGenerator(), timeProvider: timeProvider())
    }

    private func operations() -> Operations {
        let feesCalculator = cardFeesCalculator(transactionFeePolicy: transactionFeePolicy())
        return Operations(cards: cards(), feesCalculator: feesCalculator, transactions: transactions(), eventsPublisher: cardEventsPublisher())
    }
    
    func payments() -> Payments {
        let facade = PaymentsFacade(cards: cards(), operations: operations(), transactions: transactions())
        return LoggingPaymentsProxy(payments: facade)
    }
    
}
