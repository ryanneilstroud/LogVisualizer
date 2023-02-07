//
//  LocalLoader.swift
//  Puff
//
//  Created by Ryan Neil Stroud on 3/2/2023.
//

import Foundation

final class LocalLoader {
    
    private var storage: [Date] = [
        Date().add(days: -3),
        Date().add(days: -2),
        Date().add(days: -1),
        Date().add(days: -1),
        Date(),
        Date().add(hours: -1),
        Date().add(hours: -2),
        Date().add(hours: -3),
        Date().add(hours: -1),
        Date().add(days: 1),
        Date().add(days: 4),
        Date().add(days: 6),
    ]
    
    func add(date: Date) {
        storage.append(date)
    }
    
    func fetch() -> [Date] {
        return storage
    }
    
}
