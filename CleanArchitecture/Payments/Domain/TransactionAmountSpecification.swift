//
//  TransactionAmountSpecification.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

final class TransactionAmountSpecification {
    
    static func isSatisfied(_ transaction: CardTransaction, _ balance: MonetaryAmount) throws -> Bool {
        return try transaction.type == .fee || balance.isGreaterOrEqual(transaction.amount)
    }
    
    static func check(_ transaction: CardTransaction, _ balance: MonetaryAmount) throws {
        if try !isSatisfied(transaction, balance) {
            throw DomainErrors.insufficientCardBalanceException
        }
    }
    
}
