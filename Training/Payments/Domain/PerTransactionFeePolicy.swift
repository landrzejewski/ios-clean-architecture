//
//  PerTransactionFeePolicy.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 12/11/2023.
//

import Foundation

final class PerTransactionFeePolicy: TransactionFeePolicy {
   
    private let singleTransactionFee: MonetaryAmount

    init(singleTransactionFee: MonetaryAmount) {
        self.singleTransactionFee = singleTransactionFee
    }

    func execute(transactions: [CardTransaction]) -> MonetaryAmount {
        let transactionCount = transactions.count
        return singleTransactionFee.multiply(by: transactionCount)
    }
    
}
