//
//  NotificationService.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import Foundation
import UserNotifications

protocol NotificationService {
    
    /// Request authorization from the user
    func requestAuthorization() async throws
    
    /// Schedule notification for specific events
    func scheduleNotification(identifier: String, title: String, body: String, date: Date) async throws
    
    /// Cancel Notification request because it's no longer needed
    func cancelNotification(identifier: String) async throws
    
    /// Check for permission *Status*
    func checkNotificationPersmission() async -> UNAuthorizationStatus
}
