//
//  NotificationErrors.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 23.01.2025.
//

import Foundation

enum NotificationErrors: LocalizedError {
    case authorizationDenied
    case schedulingFailed
    case notificationsAreDisabled
    
    var errorDescription: String {
        switch self {
        case .authorizationDenied:
            return "Notification permission was denied."
        case .schedulingFailed:
            return "Failed to schedule the notification."
        case .notificationsAreDisabled:
            return "Failed to schedule the notification, because it's disabled by the user."
        }
    }
}
