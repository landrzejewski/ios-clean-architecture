//
//  TransactionFeePolicy.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 12/11/2023.
//

import Foundation

protocol TransactionFeePolicy {
    
    func execute(transactions: Array<CardTransaction>) -> MonetaryAmount;
    
}
