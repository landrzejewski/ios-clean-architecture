//
//  CardEventsPublisher.swift
//  Training
//
//  Created by Łukasz Andrzejewski on 12/11/2023.
//

import Foundation

protocol CardEventsPublisher {
    
    func publish(event: CardChargedEvent)
    
}
