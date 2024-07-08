//
//  validation.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

func check(_ value: String, regex: String, error: Error) throws {
    let range = NSRange(location: 0, length: value.utf16.count)
    let regex = try! NSRegularExpression(pattern: regex)
    if regex.firstMatch(in: value, options: [], range: range) == nil {
        throw error
    }
}
