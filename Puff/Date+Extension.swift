//
//  Date+Extension.swift
//  Puff
//
//  Created by Ryan Neil Stroud on 3/2/2023.
//

import Foundation

extension Date {
    
    func add(hours: Int, calendar: Calendar = .current) -> Date {
        return calendar.date(byAdding: .hour, value: hours, to: self)!
    }
    
    func add(days: Int, calendar: Calendar = .current) -> Date {
        return calendar.date(byAdding: .day, value: days, to: self)!
    }
    
    func add(months: Int, calendar: Calendar = .current) -> Date {
        return calendar.date(byAdding: .month, value: months, to: self)!
    }
    
}
