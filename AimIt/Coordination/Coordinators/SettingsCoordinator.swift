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
        
    }
    
    @ViewBuilder
    func build(sheet: SettingsSheets) -> some View {
        
    }
    
    @ViewBuilder
    func build(screenCovers: SettingsScreenCovers) -> some View {
        
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
