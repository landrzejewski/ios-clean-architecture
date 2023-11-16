//
//  CardRepository.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 12/11/2023.
//

import Foundation

protocol CardRepository {
    
    func findBy(_ cardNumber: CardNumber) -> Card?
    
    func save(card: Card)
    
}
