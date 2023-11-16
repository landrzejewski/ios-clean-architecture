//
//  SystemTimeProvider.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 12/11/2023.
//

import Foundation

final class SystemTimeProvider: TimeProvider {
   
    func getTimestamp() -> Date {
        Date()
    }
    
}
