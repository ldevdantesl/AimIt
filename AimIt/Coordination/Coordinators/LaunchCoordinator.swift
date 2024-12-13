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
    
    var onFinish: () -> ()
    
    init(onFinish: @escaping () -> Void) {
        self.onFinish = onFinish
    }
    
    @ViewBuilder
    func start() -> some View {
        IntroView()
            .environmentObject(self)
    }
    
    @ViewBuilder
    func build(screen: LaunchScreens) -> some View {
        switch screen {
        case .intro:
            IntroView()
        case .addWorkspace:
            AddWorkspaceView(onFinish: onFinish)
        }
    }
    
    func push(to screen: LaunchScreens) {
        path.append(screen)
    }
    
    func goBack() {
        path.removeLast()
    }
}
