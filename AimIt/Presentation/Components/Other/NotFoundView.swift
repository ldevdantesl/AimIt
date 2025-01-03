//
//  NoFoundView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 14.12.2024.
//

import SwiftUI

struct NotFoundView: View {
    
    private let imageName: String
    private let title: String
    private let topPadding: CGFloat
    private let subtitle: String?
    private let action: (() -> ())
    
    init(imageName: String, title: String, topPadding: CGFloat = 20, subtitle: String?, action: @escaping () -> Void) {
        self.imageName = imageName
        self.title = title
        self.topPadding = topPadding
        self.subtitle = subtitle
        self.action = action
    }
    
    
    var body: some View {
        Button(action: action) {
            VStack{
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                
                Text(title)
                    .font(.system(.title2, design: .rounded, weight: .semibold))
                    .foregroundStyle(.aiLabel)
                
                if let subtitle {
                    Text(subtitle)
                        .font(.system(.headline, design: .rounded, weight: .semibold))
                        .foregroundStyle(.aiSecondary2)
                }
            }
        }
        .padding(.top, topPadding)
    }
}

#Preview {
    NotFoundView(imageName: "NoGoals", title: "No goals Found", subtitle: "Tap to add goal", action: {})
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
