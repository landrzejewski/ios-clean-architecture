//
//  ConsoleCardEventsPublisher.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 12/11/2023.
//

import Foundation

final class ConsoleCardEventsPublisher: CardEventsPublisher {
    
    func publish(event: CardChargedEvent) {
        print("New charge on card number \(event.cardNumber.description)")
    }

}
