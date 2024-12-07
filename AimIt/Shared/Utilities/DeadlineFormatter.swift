//
//  DeadlineFormatter.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import Foundation

struct DeadlineFormatter {
    static func formatToDayMonth(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        let formattedDate = formatter.string(from: date)
        return formattedDate
    }
}
