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
    
    private let swappedTitleAndSubtitle: Bool
    
    @ViewBuilder let menuContent: Content
    
    init(
        leftButton: AIButton = AIButton(image: .empty),
        rightButton: AIButton = AIButton(image: .empty),
        title: String,
        subtitle: String? = nil,
        swappedTitleAndSubtitle: Bool = false
    ) where Content == EmptyView {
        self.leftButton = leftButton
        self.rightButton = rightButton
    
        self.title = title
        self.subtitle = subtitle
        self.menuInit = false
        self.menuContent = EmptyView()
        self.swappedTitleAndSubtitle = swappedTitleAndSubtitle
    }
    
    init(
        leftButton: AIButton = AIButton(image: .empty),
        rightMenu: AIButton = AIButton(image: .empty),
        title: String,
        subtitle: String? = nil,
        swappedTitleAndSubtitle: Bool = false,
        @ViewBuilder menuContent: () -> Content
    ) {
        self.leftButton = leftButton
        self.rightButton = rightMenu
    
        self.title = title
        self.subtitle = subtitle
        self.menuInit = true
        self.menuContent = menuContent()
        self.swappedTitleAndSubtitle = swappedTitleAndSubtitle
    }
    
    var body: some View {
        HStack{
            if leftButton.image != .empty {
                leftButton
                Spacer()
            }
            
            if let subtitle = subtitle {
                VStack(alignment: leftButton.image == .empty ? .leading : .center) {
                    if swappedTitleAndSubtitle {
                        Text(subtitle)
                            .font(.system(leftButton.image == .empty ? .title3 : .headline, design: .rounded, weight: .semibold))
                            .foregroundStyle(.aiLabel)
                            .lineLimit(1)
                            .contentTransition(.numericText())
                    }
                    
                    Text(title)
                        .font(.system(.subheadline, design: .rounded, weight: .light))
                        .foregroundStyle(.aiSecondary2)
                        .lineLimit(1)
                        .contentTransition(.numericText())
                    
                    if !swappedTitleAndSubtitle {
                        Text(subtitle)
                            .font(.system(leftButton.image == .empty ? .title3 : .headline, design: .rounded, weight: .semibold))
                            .foregroundStyle(.aiLabel)
                            .lineLimit(1)
                            .contentTransition(.numericText())
                    }
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
    AIHeaderView(rightButton: AIButton(image: .plus), title: "Good morning 🌥️", subtitle: "Buzurg Rahimzoda", swappedTitleAndSubtitle: true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
