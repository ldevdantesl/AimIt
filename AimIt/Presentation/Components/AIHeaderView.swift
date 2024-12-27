//
//  AIHomeHeaderView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import SwiftUI

struct AIHeaderView: View {
    
    private let leftButton: AIButton
    private let rightButton: AIButton
    
    private let title: String
    private let subtitle: String?
    
    init(
        leftButton: AIButton = AIButton(image: .empty),
        rightButton: AIButton = AIButton(image: .empty),
        title: String,
        subtitle: String? = nil
    ) {
        self.leftButton = leftButton
        self.rightButton = rightButton
    
        self.title = title
        self.subtitle = subtitle
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
                    
                    Text(subtitle)
                        .font(.system(leftButton.image == .empty ? .title3 : .headline, design: .rounded, weight: .semibold))
                        .foregroundStyle(.aiLabel)
                        .lineLimit(1)
                }
                .padding(.horizontal, 10)
            } else {
                Text(title)
                    .font(.system(.title3, design: .rounded, weight: .bold))
                    .foregroundStyle(.aiLabel)
            }
            
            Spacer()
            rightButton
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

#Preview {
    AIHeaderView(rightButton: AIButton(image: .plus), title: "Good morning 🌥️", subtitle: "Buzurg Rahimzoda")
}
