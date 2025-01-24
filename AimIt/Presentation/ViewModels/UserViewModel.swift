//
//  UserViewModel.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 23.01.2025.
//

import Foundation
import SwiftUI
import PhotosUI

final class UserViewModel: ObservableObject {
    @Published var fullName: String
    @Published var profileImage: UIImage?
    @Published var themeColor: Color = .aiOrange
    @Published var isNotificationEnabled: Bool
    @Published var isFirstLaunch: Bool
    @Published var notificationStatus: UNAuthorizationStatus = .notDetermined
    @Published var photoLibraryStatus: PHAuthorizationStatus = .notDetermined

    private let defaults: UserDefaults = .standard
    private let notificationService: NotificationService
    private let photoLibraryService: PhotoLibraryService
    
    init(notificationService: NotificationService, photoLibraryService: PhotoLibraryService) {
        self.notificationService = notificationService
        self.photoLibraryService = photoLibraryService
        self.fullName = defaults.string(forKey: ConstantKeys.fullName) ?? ""
        if let imageData = defaults.data(forKey: ConstantKeys.profileImage) {
            self.profileImage = UIImage(data: imageData)
        } else {
            self.profileImage = nil
        }

        self.themeColor =
            Color.fromHexString(
                defaults.string(forKey: ConstantKeys.themeColor) ?? "")
            ?? .aiOrange

        self.isNotificationEnabled =
            defaults.object(
                forKey:
                    ConstantKeys.isNotificationsEnabled) != nil
            ? defaults.bool(
                forKey: ConstantKeys.isNotificationsEnabled
            ) : true

        self.isFirstLaunch =
            defaults.object(
                forKey:
                    ConstantKeys.isFirstLaunchKey) != nil
            ? defaults.bool(
                forKey: ConstantKeys.isFirstLaunchKey
            ) : true
        
        checkPhotoLibraryPermission()
    
        Task {
            await checkNotificationPermission()
        }
    }
    
    func updateName(_ name: String) {
        self.fullName = name
        defaults.set(name, forKey: ConstantKeys.fullName)
    }
    
    func updateProfileImage(_ image: UIImage) {
        self.profileImage = image
        defaults.set(image.jpegData(compressionQuality: 0.7), forKey: ConstantKeys.profileImage)
    }
    
    func updateThemeColor(_ color: Color) {
        self.themeColor = color
        defaults.set(color.toHexString(), forKey: ConstantKeys.themeColor)
    }
    
    func updateNotificationStatus(_ status: Bool) {
        self.isNotificationEnabled = status
        defaults.set(status, forKey: ConstantKeys.isNotificationsEnabled)
    }
    
    func updateFirstLaunchStatus(_ status: Bool) {
        self.isFirstLaunch = status
        defaults.set(status, forKey: ConstantKeys.isFirstLaunchKey)
    }
    
    
    func requestNotificationPermission() async {
        do {
            try await notificationService.requestAuthorization()
            await MainActor.run {
                notificationStatus = .authorized
                isNotificationEnabled = true
            }
        } catch {
            await MainActor.run {
                notificationStatus = .denied
                isNotificationEnabled = false
            }
            print("Failed to get notification permissions: \(error.localizedDescription)")
        }
    }

    func checkNotificationPermission() async {
        let status = await notificationService.checkNotificationPersmission()
        await MainActor.run {
            self.notificationStatus = status
        }
    }
    
    func checkPhotoLibraryPermission() {
        let status = photoLibraryService.checkAuthorizationStatus()
        self.photoLibraryStatus = status
    }
    
    func requestPhotoLibraryPermission() async {
        let status = await photoLibraryService.requestAuthorizationPermission()
        await MainActor.run {
            self.photoLibraryStatus = status
        }
    }
}
