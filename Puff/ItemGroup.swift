//
//  ItemGroup.swift
//  Puff
//
//  Created by Ryan Neil Stroud on 3/2/2023.
//

import Foundation

final class ItemGroup {
    var dates: [Date]
    private let calendar: Calendar
    
    init(dates: [Date], calendar: Calendar = .current) {
        self.dates = dates
        self.calendar = calendar
    }
    
    func byDay() -> [BarMarkItem] {
        var mappedTimeslots = mapTimeslots(from: (0...23).map { String($0) })
        
        let last24Hours = Date().add(hours: -24)
        allItems(after: last24Hours).forEach { date in
            let key = calendar
                .dateComponents([.hour], from: date)
                .hour!
            mappedTimeslots[key]!.count += 1
        }
        
        return barMarks(from: mappedTimeslots)
    }
    
    func byWeek() -> [BarMarkItem] {
        var mappedTimeslots = mapTimeslots(from: calendar.shortWeekdaySymbols)
        print(mappedTimeslots)
                
        let currentWeekStartDate = calendar.date(
            from: calendar.dateComponents(
                [.yearForWeekOfYear, .weekOfYear], from: Date()))!
        allItems(after: currentWeekStartDate).forEach { date in
            let key = calendar
                .dateComponents([.weekday], from: date)
                .weekday!
            mappedTimeslots[key - 1]!.count += 1
        }
        return barMarks(from: mappedTimeslots)
    }
    
    func byMonth() -> [BarMarkItem] {
        var mappedTimeslots = mapTimeslots(from: calendar.shortMonthSymbols)

        let lastMonth = Date().add(months: -1)
        allItems(after: lastMonth).forEach { date in
            let key = calendar
                .dateComponents([.month], from: date)
                .month!
            mappedTimeslots[key]!.count += 1
        }
        
        return barMarks(from: mappedTimeslots)
    }
    
    // MARK: - Private
    
    private struct DateBarMark {
        let timeslot: String
        var count: Int
    }
    
    private func allItems(after date: Date) -> [Date] {
        return dates.filter { $0 > date }
    }
    
    private func mapTimeslots(from symbols: [String]) -> [Int: DateBarMark] {
        var dictionary: [Int: DateBarMark] = [:]
        for (index, symbol) in symbols.enumerated() {
            dictionary[index] = DateBarMark(timeslot: symbol, count: 0)
        }
        return dictionary
    }
    
    private func barMarks(from dictionary: [Int: DateBarMark]) -> [BarMarkItem] {
        return dictionary
            .sorted(by: { $0.key < $1.key })
            .compactMap { BarMarkItem(
                count: $0.value.count,
                date: $0.value.timeslot) }
    }
    
}
