//
//  TransactionService.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 12/11/2023.
//

import Foundation

final class TransactionService {
    
    private let cardRepository: CardRepository
    private let idGenerator: IdGenerator
    private let timeProvider: TimeProvider

    init(cardRepository: CardRepository, idGenerator: IdGenerator, timeProvider: TimeProvider) {
        self.cardRepository = cardRepository
        self.idGenerator = idGenerator
        self.timeProvider = timeProvider
    }

    func getTransactionsSince(cardNumber: CardNumber, timestamp: Date) throws -> [CardTransaction] {
        guard let card = cardRepository.findBy(cardNumber) else {
            throw PaymentsApplicationErrors.cardNotFoundException
        }
        return card.getTransactions
            .filter { $0.isCreatedAfter(timestamp) }
    }

    func createTransaction(value: MonetaryAmount, type: CardTransactionType) -> CardTransaction {
        let id = CardTransactionId(value: idGenerator.getNext())
        let timestamp = timeProvider.getTimestamp()
        return CardTransaction(id: id, timestamp: timestamp, amount: value, type: type)
    }
    
}
