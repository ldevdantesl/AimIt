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
                    buttonAction: nil
                )
                
                AISettingsRow(
                    title: "Theme",
                    image: "paintpalette.fill",
                    imageBackgroundShape: .roundRect,
                    textOnPusher: "Default",
                    pushAction: nil
                )
                
                AISettingsRow(
                    title: "Notifications",
                    image: "bell.fill",
                    imageBackgroundShape: .roundRect,
                    textOnPusher: "Enabled",
                    pushAction: nil
                )
                
                AISettingsRow(
                    title: "iCloud Sync",
                    image: "cloud.fill",
                    imageBackgroundShape: .roundRect,
                    isOn: .constant(true)
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
}

#Preview {
    AISettingsContent()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(DIContainer().makeWorkspaceViewModel())
}
