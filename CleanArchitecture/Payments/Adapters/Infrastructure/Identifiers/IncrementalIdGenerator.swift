//
//  IncrementalIdGenerator.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

final class IncrementalIdGenerator: IdGenerator {
    
    private var counter = 0
    
    func getNext() -> String {
        counter += 1
        return "0000\(counter)"
    }
    
}
