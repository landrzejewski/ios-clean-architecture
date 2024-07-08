//
//  CardTransaction.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

struct CardTransaction {

    private static let timestampFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy - HH:mm:ss.SS Z"
        return formatter
    }()
    
    let id: CardTransactionId
    let timestamp: Date
    let amount: MonetaryAmount
    let type: CardTransactionType
    
    
    var description: String {
        "Tx(id=\(id.description), amount=\(amount.description) type=\(type), timestamp=\(formatTimestamp())"
    }

    private func formatTimestamp() -> String {
        CardTransaction.timestampFormatter.string(from: timestamp)
    }
    
    func isPayment() -> Bool {
        type == .payment
    }

    func isCreatedAfter(_ otherTimestamp: Date) -> Bool {
        timestamp > otherTimestamp
    }
    
}
