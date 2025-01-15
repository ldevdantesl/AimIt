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
                monthlyData.append(AnalyticsMonthlyData(date: monthDate, count: 1))
            }
        }

        return monthlyData
    }
}
