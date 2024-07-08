//
//  CleanArchitectureApp.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import SwiftUI

@main
struct CleanArchitectureApp: App {
    
    let container = try! PaymentsConfiguration()
    
    var body: some Scene {
        WindowGroup {
            CardsView(viewModel: CardsViewModel(container: container))
        }
    }
}
