//
//  LaunchCoordinator.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import Foundation
import SwiftUI

final class LaunchCoordinator: ObservableObject, Coordinator {
    @Published var path: NavigationPath = NavigationPath()
    
    @Published var sheet: LaunchSheets?
    
    var onFinish: () -> ()
    
    init(onFinish: @escaping () -> Void) {
        self.onFinish = onFinish
    }
    
    @ViewBuilder
    func start() -> some View {
        LaunchIntroView()
            .environmentObject(self)
    }
    
    @ViewBuilder
    func build(screen: LaunchScreens) -> some View {
        switch screen {
        case .addWorkspace:
            LaunchAddWorkspaceView(onFinish: onFinish)
                .navigationBarBackButtonHidden()
        case .addProfile:
            LaunchAddProfileView()
                .navigationBarBackButtonHidden()
        }
    }
    
    @ViewBuilder
    func build(sheet: LaunchSheets) -> some View { }
    
    func push(to screen: LaunchScreens) {
        path.append(screen)
    }
    
    func goBack() {
        path.removeLast()
    }
}
