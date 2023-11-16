//
//  MonetaryAmount.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 12/11/2023.
//

import Foundation

struct MonetaryAmount {
    
    static let defaultCurrency = Currency(code: "EUR")
    
    let value: Double
    let currency: Currency
    
    var description: String {
        String(format: "%.2f %@", value, currency.description)
    }

    func add(_ monetaryAmount: MonetaryAmount) throws -> MonetaryAmount {
        try apply(monetaryAmount, operator: +)
    }

    func subtract(_ monetaryAmount: MonetaryAmount) throws -> MonetaryAmount {
        try apply(monetaryAmount, operator: -)
    }

    func multiply(by value: Int) -> MonetaryAmount {
        apply(Double(value), operator: *)
    }

    private func apply(_ monetaryAmount: MonetaryAmount, operator: (Double, Double) -> Double) throws -> MonetaryAmount {
        try checkCurrencyCompatibility(monetaryAmount)
        return apply(monetaryAmount.value, operator: `operator`)
    }

    private func apply(_ value: Double, operator: (Double, Double) -> Double) -> MonetaryAmount {
        let resultValue = `operator`(self.value, value)
        return MonetaryAmount(value: resultValue, currency: currency)
    }

    func isGreaterThanZero() -> Bool {
        value.sign == .plus
    }

    func isGreaterOrEqual(_ monetaryAmount: MonetaryAmount) throws -> Bool {
        try checkCurrencyCompatibility(monetaryAmount)
        return value >= monetaryAmount.value
    }

    private func checkCurrencyCompatibility(_ monetaryAmount: MonetaryAmount) throws {
        if currency.code != monetaryAmount.currency.code {
            throw PaymentsErrors.currencyMismatchException
        }
    }
    
}
