//
//  UuidGenerator.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 12/11/2023.
//

import Foundation

final class UuidGenerator: IdGenerator {
    
    func getNext() -> String {
        UUID().uuidString
    }
    
}
