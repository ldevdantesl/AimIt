//
//  DeadlineFormatter.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import Foundation

struct DeadlineFormatter {
    static func formatToTheEndOfTheDay(_ date: Date) -> Date? {
        let startOfDay = Calendar.current.startOfDay(for: date)
        return Calendar.current.date(byAdding: DateComponents(day: 1, nanosecond: -100), to: startOfDay)
    }
    
    static func formatToDaysLeftDescription(_ date: Date) -> String {
        let currentDate = Calendar.current.startOfDay(for: Date())
        let targetDate = Calendar.current.startOfDay(for: date)
        let calendar = Calendar.current
        
        guard let daysLeft = calendar.dateComponents([.day], from: currentDate, to: targetDate).day else {
            return "Invalid date"
        }
        
        if daysLeft < 0 {
            return "Deadline passed ⏰"
        } else if daysLeft == 0 {
            return "Deadline is today ❕"
        } else {
            return "\(daysLeft) day(s) left"
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
    
    static func isDayPassed(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let dueDay = calendar.startOfDay(for: date)
        return dueDay < today
    }
}
