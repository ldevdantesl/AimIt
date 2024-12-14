//
//  DeadlineFormatter.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import Foundation

struct DeadlineFormatter {
    static func formatToDaysLeft(_ date: Date) -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        
        guard let daysLeft = calendar.dateComponents([.day], from: currentDate, to: date).day else {
            return "Invalid date"
        }
        
        if daysLeft < 0 {
            return "Deadline passed"
        } else if daysLeft == 0 {
            return "Today"
        } else {
            return "\(daysLeft) days left"
        }
    }
    
    static func formatToDayMonth(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        let formattedDate = formatter.string(from: date)
        return formattedDate
    }
    
    static func formatToOnlyDay(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        let formattedDate = formatter.string(from: date)
        return formattedDate
    }
    
    static func formatToOnlyWeekday(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let formattedDate = formatter.string(from: date)
        return formattedDate
    }
    
    static func threeDaysLeft(_ date: Date) -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        
        guard let daysLeft = calendar.dateComponents([.day], from: currentDate, to: date).day else {
            return false
        }
        
        return daysLeft <= 3 && daysLeft >= 0
    }
}
