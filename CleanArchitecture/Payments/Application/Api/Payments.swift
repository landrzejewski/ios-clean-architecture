//
//  Payments.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

protocol Payments {

    func getBalanceFor(_ cardNumber: CardNumber) throws -> MonetaryAmount
    
    func getTransactionsSince(_ cardNumber: CardNumber, _ timestamp: Date) throws -> [CardTransaction]

    func chargePayment(_ cardNumber: CardNumber, _ value: MonetaryAmount) throws

    func chargeFees(_ cardNumber: CardNumber) throws
    
}
