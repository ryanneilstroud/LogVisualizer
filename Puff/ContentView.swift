//
//  ContentView.swift
//  Puff
//
//  Created by Ryan Neil Stroud on 2/2/2023.
//

import SwiftUI
import Charts

struct BarMarkItem: Identifiable {
    let id = UUID()
    
    let count: Int
    let date: String
}

enum Timeline: String {
    case day
    case week
    case month
    
    var value: String { rawValue.capitalized }
    
    static let all: [Timeline] = [.day, .week, .month]
}

struct ContentView: View {
    @State private var timelineView: Timeline = .day
    @State private var barMarkItems: [BarMarkItem] = []
    
    let group = ItemGroup(dates: LocalLoader().fetch())
    
    private func getDates(for view: Timeline) -> [BarMarkItem] {
        switch view {
        case .day:   return group.byDay()
        case .week:  return group.byWeek()
        case .month: return group.byMonth()
        }
    }
    
    var body: some View {
        VStack {
            Picker("Format", selection: $timelineView) {
                ForEach(Timeline.all, id: \.self) {
                    Text($0.value)
                }
            }
            .pickerStyle(.segmented)
            .padding(20)
            .onChange(of: timelineView) { newValue in
                barMarkItems = getDates(for: timelineView)
            }
            Chart {
                ForEach(barMarkItems) { date in
                    BarMark(
                        x: .value("Date", date.date),
                        y: .value("Puffs", date.count)
                    )
                    .foregroundStyle(.pink)
                    .cornerRadius(10)
                }
            }
            Button("log") {
                group.dates += [Date()]
                barMarkItems = getDates(for: timelineView)
            }
            .buttonStyle(.borderedProminent)
            .foregroundColor(.white)
            .tint(.pink)
            .frame(height: 50)
        }
        .onAppear {
            barMarkItems = getDates(for: timelineView)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
