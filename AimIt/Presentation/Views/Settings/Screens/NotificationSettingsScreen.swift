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
                    textOnPusher: "Granted",
                    buttonAction: {})

                AISettingsRow(
                    title: "Notifications",
                    image: "bell.badge.fill",
                    isOn: $isNotificationEnabled
                )
                .onChange(of: isNotificationEnabled) { _ in
                    self.userVM.updateNotificationStatus(isNotificationEnabled)
                }

                Text("Note: You can always change it later in the settings")
                    .font(.system(.footnote, design: .rounded, weight: .light))
                    .foregroundStyle(.aiSecondary2)
            }
        }
        .background(Color.aiBackground)
        .onAppear(perform: setup)
        .navigationBarBackButtonHidden()
    }

    private func setup() {
        withAnimation {
            self.isNotificationEnabled = self.userVM.isNotificationEnabled
        }
    }
}

#Preview {
    NotificationSettingsScreen()
        .environmentObject(UserViewModel())
}
