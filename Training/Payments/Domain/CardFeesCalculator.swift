//
//  CardFeesCalculator.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 12/11/2023.
//

import Foundation

final class CardFeesCalculator {
    
    private let transactionFeePolicy: TransactionFeePolicy

    init(transactionFeePolicy: TransactionFeePolicy) {
        self.transactionFeePolicy = transactionFeePolicy
    }

    func calculate(_ transactions: [CardTransaction]) -> MonetaryAmount {
        let unsettledTransactions = transactions.prefix(while: { $0.isPayment() })
        return transactionFeePolicy.execute(transactions: Array(unsettledTransactions))
    }
    
}
