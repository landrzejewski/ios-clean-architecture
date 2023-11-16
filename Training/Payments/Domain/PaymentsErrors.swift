//
//  PaymentsErrors.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 12/11/2023.
//

import Foundation

enum PaymentsErrors: Error {
    
    case invalidCardNumber
    case currencyMismatchException
    case cardExpiredException
    case insufficientCardBalanceException
    case invalidCardNumberException
    
}
