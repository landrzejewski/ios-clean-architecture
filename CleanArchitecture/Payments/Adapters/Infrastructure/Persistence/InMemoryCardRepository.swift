//
//  InMemoryCardRepository.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

final class InMemoryCardRepository: CardRepository {
    
    private var cards: [CardNumber: Card] = [:]

    func findBy(_ number: CardNumber) -> Card? {
        cards[number]
    }

    func save(card: Card) {
        cards[card.getNumber] = card.copy()
    }
    
}
