//
//  SystemTimeProvider.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

final class SystemTimeProvider: TimeProvider {
    
    func getTimestamp() -> Date {
        Date()
    }
    
}
