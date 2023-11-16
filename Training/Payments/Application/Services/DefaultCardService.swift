//
//  DefaultCardService.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 12/11/2023.
//

import Foundation

final class DefaultCardService: CardService {
    
    private let cardRepository: CardRepository

    init(cardRepository: CardRepository) {
        self.cardRepository = cardRepository
    }

    func apply(_ cardNumber: CardNumber, _ operation: (Card) -> CardTransaction?) throws {
        guard let card = cardRepository.findBy(cardNumber) else {
            throw PaymentsApplicationErrors.cardNotFoundException
        }
        if let transaction = operation(card) {
            try card.add(transaction)
            cardRepository.save(card: card)
        }
    }
    
    func getBalance(_ cardNumber: CardNumber) throws -> MonetaryAmount {
        guard let card = cardRepository.findBy(cardNumber) else {
            throw PaymentsApplicationErrors.cardNotFoundException
        }
        return card.getBalance
    }

}

