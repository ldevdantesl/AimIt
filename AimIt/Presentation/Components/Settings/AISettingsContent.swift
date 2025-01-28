//
//  AIContentSettings.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 20.01.2025.
//

import SwiftUI

struct AISettingsContent: View {
    @State private var isShowingReview: Bool = false
    
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
                    title: "Privacy & Policy",
                    image: "hand.raised.fill",
                    imageBackgroundShape: .roundRect,
                    buttonAction: openPrivacy
                )
                
                AISettingsRow(
                    title: "Feedback",
                    image: "quote.bubble.fill",
                    imageBackgroundShape: .roundRect,
                    buttonAction: { isShowingReview.toggle() }
                )
                
                AISettingsShareButton(
                    url: Constants.APP_URL,
                    subject: "Checkout the app.",
                    message: "I really recommend u this app..."
                )
                
                AISettingsRow(
                    title: "Review",
                    image: "star",
                    imageBackgroundShape: .roundRect,
                    buttonAction: { isShowingReview.toggle() }
                )
                
                AISettingsRow(
                    title: "Website",
                    image: "globe",
                    imageBackgroundShape: .roundRect,
                    buttonAction: openWebsite
                )
            }
            .alert(isPresented: $isShowingReview) {
                Alert(
                    title: Text("Review Request Simulation"),
                    message: Text("Once the app is live, you'll be able to leave a review on the App Store."),
                    dismissButton: .default(Text("Got it!"))
                )
            }
        }
    }
    
    private var notificationText: String {
        userVM.isNotificationEnabled && userVM.notificationStatus == .authorized ? "Enabled" : "Disabled"
    }
    
    private func openPrivacy() {
        ApplicationOpener.openURL(URLString: Constants.PRIVACY_URL)
    }
    
    private func openWebsite() {
        ApplicationOpener.openURL(URLString: Constants.WEBSITE_URL)
    }
}

#Preview {
    AISettingsContent()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(DIContainer().makeWorkspaceViewModel())
}
