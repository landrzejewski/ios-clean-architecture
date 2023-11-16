//
//  TransactionTimeSpecification.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 12/11/2023.
//

import Foundation

final class TransactionTimeSpecification {

    static func isSatisfied(_ transaction: CardTransaction, _ cardExpirationDate: Date) -> Bool {
        return cardExpirationDate > transaction.timestamp
    }

    static func check(_ transaction: CardTransaction, _ cardExpirationDate: Date) throws {
        if !isSatisfied(transaction, cardExpirationDate) {
            throw PaymentsErrors.cardExpiredException
        }
    }
    
}
