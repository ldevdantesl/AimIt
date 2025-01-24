//
//  NotificationSettingsScreen.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 23.01.2025.
//

import SwiftUI

struct NotificationSettingsScreen: View {
    @EnvironmentObject var coordinator: SettingsCoordinator
    @EnvironmentObject var userVM: UserViewModel
    @State private var isNotificationEnabled: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AIHeaderView(
                    leftButton: AIButton(
                        image: .back,
                        action: coordinator.goBack
                    ),
                    title: "Remind yourself.",
                    subtitle: "Notifications"
                )

                AISettingsRow(
                    title: "Notification Status",
                    image: "checkmark.seal.fill",
                    textOnPusher: notificationStatus(),
                    buttonAction: nil
                )
                
                AISettingsRow(
                    title: "Notifications",
                    image: "bell.badge.fill",
                    isOn: $isNotificationEnabled
                )
                .disabled(userVM.notificationStatus != .authorized)
                .onChange(of: isNotificationEnabled) { _ in
                    self.userVM.updateNotificationStatus(isNotificationEnabled)
                }

                if userVM.notificationStatus != .authorized {
                    NotFoundView(
                        imageName: ImageNames.noNotifications,
                        title: "Permission Denied",
                        verticalPadding: 100,
                        subtitle: "Tap to change it.",
                        action: ApplicationOpener.openSettings
                    )
                    
                    AIFooterNote(
                        text: "Permission is not granted",
                        condition: userVM.notificationStatus != .authorized
                    )
                } else {
                    AIFooterNote(
                        text: "You can always change it later in the settings."
                    )
                }
            }
        }
        .background(Color.aiBackground)
        .onAppear(perform: setup)
        .navigationBarBackButtonHidden()
    }
    
    private func notificationStatus() -> String {
        switch userVM.notificationStatus {
        case .authorized: "Granted"
        case .denied: "Denied"
        case .notDetermined: "Not Determined"
        default: "Unknown"
        }
    }

    private func setup() {
        withAnimation {
            Task{
               await userVM.checkNotificationPermission()
            }
            self.isNotificationEnabled = self.userVM.isNotificationEnabled
        }
    }
}

#Preview {
    NotificationSettingsScreen()
        .environmentObject(DIContainer().makeUserViewModel())
}
