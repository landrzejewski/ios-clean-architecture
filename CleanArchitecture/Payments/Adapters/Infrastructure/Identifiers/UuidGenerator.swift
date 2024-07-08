//
//  UuidGenerator.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

final class UuidGenerator: IdGenerator {
    
    func getNext() -> String {
        UUID().uuidString
    }
    
}
