//
//  TimeProvider.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

protocol TimeProvider {
    
    func getTimestamp() -> Date
    
}
