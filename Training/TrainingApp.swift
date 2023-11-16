//
//  TrainingApp.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 10/11/2023.
//

import SwiftUI

@main
struct TrainingApp: App {
    
    let paymentsConfiguration = PaymentsConfiguration()
    
    var body: some Scene {
        WindowGroup {
            Payments(viewModel: PaymentsViewModel(paymentsConfiguration: paymentsConfiguration))
        }
    }
    
}
