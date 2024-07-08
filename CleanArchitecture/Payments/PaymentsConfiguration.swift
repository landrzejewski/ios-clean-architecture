//
//  PaymentsConfiguration.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

final class PaymentsConfiguration {
    
    func idGenerator() -> IdGenerator {
        UuidGenerator()
    }

    func timeProvider() -> TimeProvider {
        SystemTimeProvider()
    }

    func cardRepository() -> CardRepository {
        InMemoryCardRepository()
    }

    func cardEventsPublisher() -> CardEventsPublisher {
        ConsoleCardEventsPublisher()
    }

    func transactionFeePolicy() -> TransactionFeePolicy {
        PerTransactionFeePolicy(singleTransactionFee: MonetaryAmount(value: 1, currency: Currency(code: "EUR")))
    }

    func cardFeesCalculator(transactionFeePolicy: TransactionFeePolicy) -> CardFeesCalculator {
        CardFeesCalculator(transactionFeePolicy: transactionFeePolicy)
    }

    func cards(cardRepository: CardRepository) -> Cards {
        return Cards(cardRepository: cardRepository)
    }

    func transactions(cardRepository: CardRepository, idGenerator: IdGenerator, timeProvider: TimeProvider) -> Transactions {
        Transactions(cardRepository: cardRepository, idGenerator: idGenerator, timeProvider: timeProvider)
    }

    func operations(cards: Cards, feesCalculator: CardFeesCalculator, trasactions: Transactions, eventsPublisher: CardEventsPublisher) -> Operations {
        Operations(cards: cards, feesCalculator: feesCalculator, transactions: trasactions, eventsPublisher: eventsPublisher)
    }
    
}
