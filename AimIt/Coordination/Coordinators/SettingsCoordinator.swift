//
//  SettingsCoordinator.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

final class SettingsCoordinator: ObservableObject, Coordinator {
    @Published var path: NavigationPath = NavigationPath()
    
    @Published var sheet: SettingsSheets?
    @Published var fullScreenCover: SettingsScreenCovers?
    
    @ViewBuilder
    func start() -> some View {
        SettingsView()
            .environmentObject(self)
    }
    
    @ViewBuilder
    func build(screen: SettingsScreens) -> some View {
        switch screen {
        case .completedGoalsAndMilestones: CompletedGoalsAndMilestonesScreen()
        case .notificationSettings: NotificationSettingsScreen()
        }
    }
    
    @ViewBuilder
    func build(sheet: SettingsSheets) -> some View {
        NavigationStack{
            switch sheet {
            case .totalWorkspaces:
                TotalWorkspacesSettingsSheet()
                    .presentationDetents(sheet.detents)
                    .presentationDragIndicator(.visible)
            case .themeColor:
                ChangeThemeColorSheet()
                    .presentationDetents(sheet.detents)
                    .presentationDragIndicator(.hidden)
            }
        }
    }
    
    @ViewBuilder
    func build(screenCovers: SettingsScreenCovers) -> some View {
        NavigationStack{
            switch screenCovers {
            case .editProfile: EditProfileScreenCover()
            }
        }
    }
    
    func present(sheet: SettingsSheets) {
        self.sheet = sheet
    }
    
    func present(fullScreenCover: SettingsScreenCovers) {
        self.fullScreenCover = fullScreenCover
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    func push(to screen: SettingsScreens) {
        path.append(screen)
    }
    
    func goBack() {
        path.removeLast()
    }
}
