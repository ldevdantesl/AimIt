//
//  AIHomeHeaderView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import SwiftUI

struct AIHeaderView<Content: View>: View {
    
    private let leftButton: AIButton
    private let rightButton: AIButton
    
    private let title: String
    private let subtitle: String?
    
    private let menuInit: Bool
    
    @ViewBuilder let menuContent: Content
    
    init(
        leftButton: AIButton = AIButton(image: .empty),
        rightButton: AIButton = AIButton(image: .empty),
        title: String,
        subtitle: String? = nil
    )  where Content == EmptyView {
        self.leftButton = leftButton
        self.rightButton = rightButton
    
        self.title = title
        self.subtitle = subtitle
        self.menuInit = false
        self.menuContent = EmptyView()
    }
    
    init(
        leftButton: AIButton = AIButton(image: .empty),
        rightMenu: AIButton = AIButton(image: .empty),
        title: String,
        subtitle: String? = nil,
        @ViewBuilder menuContent: () -> Content
    ) {
        self.leftButton = leftButton
        self.rightButton = rightMenu
    
        self.title = title
        self.subtitle = subtitle
        self.menuInit = true
        self.menuContent = menuContent()
    }
    
    var body: some View {
        HStack{
            if leftButton.image != .empty {
                leftButton
                Spacer()
            }
            
            if let subtitle = subtitle {
                VStack(alignment: leftButton.image == .empty ? .leading : .center) {
                    Text(title)
                        .font(.system(.subheadline, design: .rounded, weight: .light))
                        .foregroundStyle(.aiSecondary2)
                        .lineLimit(1)
                        .contentTransition(.numericText())
                    
                    Text(subtitle)
                        .font(.system(leftButton.image == .empty ? .title3 : .headline, design: .rounded, weight: .semibold))
                        .foregroundStyle(.aiLabel)
                        .lineLimit(1)
                        .contentTransition(.numericText())
                }
                .padding(.horizontal, 10)
            } else {
                Text(title)
                    .font(.system(.title3, design: .rounded, weight: .bold))
                    .foregroundStyle(.aiLabel)
            }
            
            Spacer()
            if menuInit {
                Menu {
                    menuContent
                } label: {
                    rightButton
                }
            } else {
                rightButton
            }
        }
        .padding(.trailing, rightButton.image == .empty ? 10 : 20)
        .padding(.leading, leftButton.image == .empty ? 10 : 20)
        .padding(.top, 10)
    }
}

#Preview {
    AIHeaderView(rightButton: AIButton(image: .plus), title: "Good morning 🌥️", subtitle: "Buzurg Rahimzoda")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
