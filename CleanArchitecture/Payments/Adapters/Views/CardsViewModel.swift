//
//  CardsViewModel.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

@Observable
final class CardsViewModel {
    
    private let container: PaymentsConfiguration
    
    init(container: PaymentsConfiguration) {
        self.container = container
    }
    
    func start() throws {
        let payments = container.payments()
             
        let currency = Currency(code: "EUR")
        let cardNumber = try CardNumber(value: "1234567890123456")!
        
        // Operations
        try payments.chargePayment(cardNumber, MonetaryAmount(value: 10, currency: currency))
        try payments.chargePayment(cardNumber, MonetaryAmount(value: 20, currency: currency))
        try payments.chargeFees(cardNumber)
        try payments.chargePayment(cardNumber, MonetaryAmount(value: 15, currency: currency))
        
        let yesterday = Date().addingTimeInterval(-24 * 60 * 60)
        print("Transactions on card number \(cardNumber.description):")
        let cardTransactions = try payments.getTransactionsSince(cardNumber, yesterday)
        cardTransactions.forEach { transaction in
            print(transaction.description)
        }
        
        print("Card balance: \(try payments.getBalance(cardNumber).description)")
    }
    
}
