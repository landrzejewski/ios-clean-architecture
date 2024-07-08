//
//  ConsoleCardEventsPublisher.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

final class ConsoleCardEventsPublisher: CardEventsPublisher {
    
    func publish(event: CardChargedEvend) {
        print("New charge on card number \(event.cardNumber)")
    }
    
}
