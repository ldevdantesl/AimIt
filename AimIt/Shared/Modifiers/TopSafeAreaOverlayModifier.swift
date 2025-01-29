//
//  TopSafeAreaBlocker.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import Foundation
import SwiftUI

struct TopSafeAreaOverlayModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .top){
                Rectangle()
                    .fill(.aiBackground)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .ignoresSafeArea(.all, edges: .top)
            }
    }
}
