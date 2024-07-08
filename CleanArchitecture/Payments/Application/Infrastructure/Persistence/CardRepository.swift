//
//  CardRepository.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

protocol CardRepository {
    
    func findBy(_ cardNumber: CardNumber) -> Card?
    
    func save(card: Card)
    
}
