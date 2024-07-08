//
//  PerTransactionFeePolicy.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

final class PerTransactionFeePolicy: TransactionFeePolicy {
   
    private let singleTransactionFee: MonetaryAmount

    init(singleTransactionFee: MonetaryAmount) {
        self.singleTransactionFee = singleTransactionFee
    }

    func execute(_ transactions: [CardTransaction]) -> MonetaryAmount {
        let transactionCount = transactions.count
        return singleTransactionFee.multiply(by: transactionCount)
    }
    
}
