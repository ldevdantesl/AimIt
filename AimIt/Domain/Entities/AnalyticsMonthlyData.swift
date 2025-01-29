//
//  MonthlyData.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 15.01.2025.
//

import Foundation

struct AnalyticsMonthlyData: Identifiable {
    let id: UUID = UUID()
    let date: Date
    let count: Int
}
