//
//  TransactionAddedEvent.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

struct TransactionAddedEvent {
    
    let cardNumber: CardNumber
    let cardTransaction: CardTransaction
    
}
