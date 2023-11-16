//
//  PaymentsConfiguration.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 12/11/2023.
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
        PerTransactionFeePolicy(singleTransactionFee: MonetaryAmount(value: 1, currency: MonetaryAmount.defaultCurrency))
    }

    func cardFeesCalculator(transactionFeePolicy: TransactionFeePolicy) -> CardFeesCalculator {
        CardFeesCalculator(transactionFeePolicy: transactionFeePolicy)
    }

    func cardService(cardRepository: CardRepository) -> CardService {
        let cardService = DefaultCardService(cardRepository: cardRepository)
        return LoggingCardService(cardService: cardService)
    }

    func transactionService(cardRepository: CardRepository, idGenerator: IdGenerator, timeProvider: TimeProvider) -> TransactionService {
        TransactionService(cardRepository: cardRepository, idGenerator: idGenerator, timeProvider: timeProvider)
    }

    func chargeService(cardService: CardService, cardEventsPublisher: CardEventsPublisher, cardFeesCalculator: CardFeesCalculator, transactionService: TransactionService) -> ChargeService {
        ChargeService(cardService: cardService, cardEventsPublisher: cardEventsPublisher, feesCalculator: cardFeesCalculator, transactionService: transactionService)
    }

    func cardsFacade(cardService: CardService, transactionService: TransactionService, chargeService: ChargeService) -> CardsFacade {
        CardsFacade(cardService: cardService, transactionService: transactionService, chargeService: chargeService)
    }
    
}
