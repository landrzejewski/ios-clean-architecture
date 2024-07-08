//
//  MonetaryAmount.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

struct MonetaryAmount {
    
    let value: Double
    let currency: Currency
    
    var description: String {
        String(format: "%.2f %@", value, currency.description)
    }
    
    func add(_ monetaryAmount: MonetaryAmount) throws -> MonetaryAmount {
        try apply(monetaryAmount, operation: +)
    }
    
    func subtract(_ monetaryAmount: MonetaryAmount) throws -> MonetaryAmount {
        try apply(monetaryAmount, operation: -)
    }
    
    func multiply(by value: Int) -> MonetaryAmount {
        apply(Double(value), operation: *)
    }
    
    func isGreaterThanZero() -> Bool {
        value.sign == .plus
    }

    func isGreaterOrEqual(_ monetaryAmount: MonetaryAmount) throws -> Bool {
        try checkCurrencyCompatibility(monetaryAmount)
        return value >= monetaryAmount.value
    }
    
    private func apply(_ monetaryAmount: MonetaryAmount, operation: (Double, Double) -> Double) throws -> MonetaryAmount {
        try checkCurrencyCompatibility(monetaryAmount)
        return apply(monetaryAmount.value, operation: operation)
    }
    
    private func apply(_ value: Double, operation: (Double, Double) -> Double) -> MonetaryAmount {
        let resultValue = operation(self.value, value)
        return MonetaryAmount(value: resultValue, currency: currency)
    }
    
    private func checkCurrencyCompatibility(_ monetaryAmount: MonetaryAmount) throws {
        if currency.code != monetaryAmount.currency.code {
            throw DomainErrors.currencyMismatchException
        }
    }
    
}
