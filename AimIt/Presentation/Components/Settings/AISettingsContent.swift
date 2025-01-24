//
//  AIContentSettings.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 20.01.2025.
//

import SwiftUI

struct AISettingsContent: View {
    @EnvironmentObject var coordinator: SettingsCoordinator
    @EnvironmentObject var workspaceVM: WorkspaceViewModel
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            VStack{
                AIInfoField(title: "Content", info: "")
                
                AISettingsRow(
                    title: "Workspaces",
                    image: "briefcase.fill",
                    textOnPusher: workspaceVM.workspaces.count.description,
                    pushAction: { coordinator.present(sheet: .totalWorkspaces) }
                )
                
                AISettingsRow(
                    title: "Completed",
                    image: "checkmark.circle.fill",
                    pushAction: { coordinator.push(to: .completedGoalsAndMilestones)}
                )
            }
            
            VStack{
                AIInfoField(title: "Preferences", info: "")
                
                AISettingsRow(
                    title: "Language",
                    image: "globe",
                    imageBackgroundShape: .roundRect,
                    textOnPusher: "English",
                    buttonAction: ApplicationOpener.openSettings
                )
                
                AISettingsRow(
                    title: "Theme",
                    image: "paintpalette.fill",
                    imageBackgroundShape: .roundRect,
                    pushAction: { coordinator.present(sheet: .themeColor) }
                )
                
                AISettingsRow(
                    title: "Notifications",
                    image: "bell.fill",
                    imageBackgroundShape: .roundRect,
                    textOnPusher: notificationText,
                    pushAction: { coordinator.push(to: .notificationSettings) }
                )
            }
            
            VStack {
                AIInfoField(title: "Other", info: nil)
                
                AISettingsRow(
                    title: "Help",
                    image: "questionmark",
                    imageBackgroundShape: .roundRect,
                    buttonAction: nil
                )
                
                AISettingsRow(
                    title: "Feedback",
                    image: "quote.bubble.fill",
                    imageBackgroundShape: .roundRect,
                    buttonAction: nil
                )
                
                AISettingsRow(
                    title: "Share",
                    image: "arrowshape.turn.up.right.fill",
                    imageBackgroundShape: .roundRect,
                    buttonAction: nil
                )
                
                AISettingsRow(
                    title: "Review",
                    image: "star",
                    imageBackgroundShape: .roundRect,
                    buttonAction: nil
                )
            }
        }
    }
    
    private var notificationText: String {
        userVM.isNotificationEnabled && userVM.notificationStatus == .authorized ? "Enabled" : "Disabled"
    }
}

#Preview {
    AISettingsContent()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(DIContainer().makeWorkspaceViewModel())
}
