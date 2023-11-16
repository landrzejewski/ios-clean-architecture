//
//  Payments.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 10/11/2023.
//

import SwiftUI

struct Payments: View {
    
    var viewModel: PaymentsViewModel
    
    var body: some View {
        VStack {
            Text("Payments")
        }
        .padding()
        .onAppear {
            try? viewModel.start()
        }
    }
    
}
