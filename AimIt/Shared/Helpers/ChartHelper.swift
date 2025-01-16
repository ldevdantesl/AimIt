//
//  ChartHelper.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 15.01.2025.
//

import Foundation

struct ChartHelper {
    static func mergeResultsWithDefaults(results: [AnalyticsMonthlyData]) -> [AnalyticsMonthlyData] {
        let defaultData = generateDefaultMonthlyData()

        var mergedData: [AnalyticsMonthlyData] = []
        for defaultMonth in defaultData {
            if let result = results.first(where: { Calendar.current.isDate($0.date, equalTo: defaultMonth.date, toGranularity: .month) }) {
                mergedData.append(result)
            } else {
                mergedData.append(defaultMonth)
            }
        }

        return mergedData
    }
    
    static func generateDefaultMonthlyData() -> [AnalyticsMonthlyData] {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        var monthlyData: [AnalyticsMonthlyData] = []

        for month in 1...12 {
            if let monthDate = calendar.date(from: DateComponents(year: currentYear, month: month, day: 1)) {
                monthlyData.append(AnalyticsMonthlyData(date: monthDate, count: 0))
            }
        }

        return monthlyData
    }
    
    static func getMaximumCountValue(from results: [AnalyticsMonthlyData]) -> Int {
        return results.map(\.count).max() ?? 0
    }
    
    static func chartYScaleDomain(data: [AnalyticsMonthlyData], incrementedBy: Int = 1) -> ClosedRange<Int> {
        0...ChartHelper.getMaximumCountValue(from: data) + incrementedBy
    }
}
