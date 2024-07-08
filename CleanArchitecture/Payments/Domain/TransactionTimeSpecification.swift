//
//  TransactionTimeSpecification.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation


import Foundation

final class TransactionTimeSpecification {

    static func isSatisfied(_ transaction: CardTransaction, _ cardExpirationDate: Date) -> Bool {
        return cardExpirationDate > transaction.timestamp
    }

    static func check(_ transaction: CardTransaction, _ cardExpirationDate: Date) throws {
        if !isSatisfied(transaction, cardExpirationDate) {
            throw DomainErrors.cardExpiredException
        }
    }
    
}
