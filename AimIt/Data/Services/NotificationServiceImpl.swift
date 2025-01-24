//
//  NetworkServiceImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import Foundation
import UserNotifications

final class NotificationServiceImpl: NotificationService {
    
    private let center: UNUserNotificationCenter = .current()
    
    func requestAuthorization() async throws {
        let permission = try await center.requestAuthorization(options: [.badge, .alert, .sound])
        
        guard permission else {
            throw NotificationErrors.authorizationDenied
        }
    }
    
    func scheduleNotification (
        identifier: String,
        title: String,
        body: String,
        date: Date
    ) async throws {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        try await center.add(request)
    }
    
    func cancelNotification(identifier: String) async throws {
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    func checkNotificationPersmission() async -> UNAuthorizationStatus {
        let settings = await center.notificationSettings()
        return settings.authorizationStatus
    }
}
