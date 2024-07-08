//
//  Cards.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

final class Cards {
    
    private let cardRepository: CardRepository
    
    init(cardRepository: CardRepository) {
        self.cardRepository = cardRepository
    }
    
    func getBalance(forCard cardNumber: CardNumber) throws -> MonetaryAmount {
        guard let card = cardRepository.findBy(cardNumber) else {
            throw ApplicationErrors.cardNotFoundException
        }
        return card.getBalance
    }
    
    func apply(_ cardNumber: CardNumber, _ operation: (Card) -> CardTransaction?) throws {
        guard let card = cardRepository.findBy(cardNumber) else {
            throw ApplicationErrors.cardNotFoundException
        }
        if let transaction = operation(card) {
            try card.add(transaction)
            cardRepository.save(card: card)
        }
    }
    
}
