//
//  NoFoundView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 14.12.2024.
//

import SwiftUI

struct NotFoundView: View {
    
    private let imageName: String?
    private let title: String
    private let verticalPadding: CGFloat
    private let subtitle: String?
    private let action: (() -> ())?
    
    init(
        imageName: String? = nil,
        title: String,
        verticalPadding: CGFloat = 60,
        subtitle: String?,
        action: (() -> Void)?
    ) {
        self.imageName = imageName
        self.title = title
        self.verticalPadding = verticalPadding
        self.subtitle = subtitle
        self.action = action
    }
    
    
    var body: some View {
        Button(action: { action?() }) {
            VStack{
                if let imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                }
                
                Text(title)
                    .font(.system(.title3, design: .rounded, weight: .semibold))
                    .foregroundStyle(.aiLabel)
                
                if let subtitle {
                    Text(subtitle)
                        .font(.system(.subheadline, design: .rounded, weight: .semibold))
                        .foregroundStyle(.aiSecondary2)
                }
            }
        }
        .padding(.vertical, verticalPadding)
    }
}

#Preview {
    NotFoundView(imageName: "NoGoals", title: "No goals Found", subtitle: "Tap to add goal", action: {})
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
