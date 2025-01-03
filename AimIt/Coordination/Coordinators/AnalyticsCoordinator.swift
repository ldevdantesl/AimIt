//
//  AnalyticsCoordinator.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import Foundation
import SwiftUI

final class AnalyticsCoordinator: ObservableObject, Coordinator {
    @Published var path: NavigationPath = NavigationPath()
    
    @Published var sheet: AnalyticsSheets?
    @Published var fullScreenCover: AnalyticsScreenCovers?
    
    @ViewBuilder
    func start() -> some View {
        AnalyticsView()
            .environmentObject(self)
    }
    
    @ViewBuilder
    func build(screen: AnalyticsScreens) -> some View {
        
    }
    
    @ViewBuilder
    func build(sheet: AnalyticsSheets) -> some View {
        
    }
    
    @ViewBuilder
    func build(screenCovers: AnalyticsScreenCovers) -> some View {
        
    }
    
    func present(sheet: AnalyticsSheets) {
        self.sheet = sheet
    }
    
    func present(fullScreenCover: AnalyticsScreenCovers) {
        self.fullScreenCover = fullScreenCover
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    func push(to screen: AnalyticsScreens) {
        path.append(screen)
    }
    
    func goBack() {
        path.removeLast()
    }
}
