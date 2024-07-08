//
//  LoggingPaymentsProxy.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

final class LoggingPaymentsProxy: Payments {

    private let payments: Payments
    
    init(payments: Payments) {
        self.payments = payments
    }
    
    func getBalance(_ cardNumber: CardNumber) throws -> MonetaryAmount {
        print("Get balance for card with number: \(cardNumber)")
        return try payments.getBalance(cardNumber)
    }
    
    func getTransactionsSince(_ cardNumber: CardNumber, _ timestamp: Date) throws -> [CardTransaction] {
        try payments.getTransactionsSince(cardNumber, timestamp)
    }
    
    func chargePayment(_ cardNumber: CardNumber, _ value: MonetaryAmount) throws {
        try payments.chargePayment(cardNumber, value)
    }
    
    func chargeFees(_ cardNumber: CardNumber) throws {
        try payments.chargeFees(cardNumber)
    }
    
}
