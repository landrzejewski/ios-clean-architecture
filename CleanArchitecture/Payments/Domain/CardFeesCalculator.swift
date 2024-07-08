//
//  CardFeesCalculator.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

final class CardFeesCalculator {
    
    private let transactionFeePolicy: TransactionFeePolicy
    
    init(transactionFeePolicy: TransactionFeePolicy) {
        self.transactionFeePolicy = transactionFeePolicy
    }
    
    func calculate(_ transactions: [CardTransaction]) -> MonetaryAmount {
        let unsettledTransaction = Array(transactions.prefix(while: { $0.isPayment() }))
        return transactionFeePolicy.execute(unsettledTransaction)
    }
    
}
