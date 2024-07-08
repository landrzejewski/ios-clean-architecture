//
//  CardEventsPublisher.swift
//  CleanArchitecture
//
//  Created by Łukasz Andrzejewski on 08/07/2024.
//

import Foundation

protocol CardEventsPublisher {
    
    func publish(event: CardChargedEvend)
    
}
