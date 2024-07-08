//
//  DomainErrors.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

enum DomainErrors: Error {
    
    case invalidCardNumber
    case currencyMismatchException
    case insufficientCardBalanceException
    case cardExpiredException
    
}
