//
//  AIButton.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import SwiftUI

struct AIButton: View {
    
    enum ImageType: String {
        case back
        case ellipsis
        case bell
        case plus
        case xmark
        case empty
        case ava
        case edit
        case chevronDown
        case briefCase
    }

    let title: String?
    let image: ImageType
    let action: (() -> ())?
    let backColor: Color
    let foreColor: Color
    
    ///Default Initializer. Used for presenting button in a circle using *ImageType*\n
    init(
        image: ImageType,
        backColor: Color = .aiSecondBackground,
        foreColor: Color = .aiBlack,
        action: (() -> ())? = nil
    ) {
        self.title = nil
        self.image = image
        self.action = action
        self.backColor = backColor
        self.foreColor = foreColor
    }
    
    ///Initializer used for presenting a button filled throughout the whole screenwidth.\n Use it in a bottom toolbar positions.
    init(title: String, color: Color = .accentColor, action: (() -> ())? = nil) {
        self.title = title
        self.action = action
        self.image = .empty
        self.backColor = color
        self.foreColor = .aiLabel
    }
    
    var body: some View {
        Button{
            withAnimation {
                action?()
                AIHaptics.shared.generate()
            }
        } label: {
            if let title = title {
                Text(title)
                    .font(.system(.headline, design: .rounded, weight: .semibold))
                    .foregroundStyle(foreColor)
                    .frame(minWidth: UIConstants.screenWidth - 40, maxWidth: .infinity)
                    .frame(height: 50)
                    .background(backColor.gradient, in: .rect(cornerRadius: 25))
                    .shadow(color: Color.aiBlack.opacity(0.3), radius: 15, x: 0, y: 0)
                    .shadow(color: Color.aiBlack.opacity(0.2), radius: 30, x: 0, y: 0)
                    .padding(.horizontal, 20)
                    .contentTransition(.numericText())
            } else {
                if image != .empty{
                    ZStack {
                        Circle()
                            .fill(backColor.opacity(0.4))
                            .frame(width: 52, height: 52)
                            .zIndex(1)
                        
                        Circle()
                            .fill(backColor)
                            .frame(width: 45, height: 45)
                            .zIndex(2)
                        
                        makeImage()
                            .resizable()
                            .scaledToFit()
                            .frame(width: image == .chevronDown ? 20 : 25, height: 20)
                            .zIndex(2)
                            .foregroundStyle(foreColor)
                    }
                    .frame(width: 40, height: 40)
                }
            }
        }
    }
    
    
    private func makeImage() -> Image {
        switch image {
        case .back:         Image(systemName: "chevron.left")
        case .ellipsis:     Image(systemName: "ellipsis")
        case .bell:         Image(systemName: "bell")
        case .plus:         Image(systemName: "plus")
        case .xmark:        Image(systemName: "xmark")
        case .empty:        Image(systemName: "circle.fill")
        case .ava:          Image(systemName: "person.fill")
        case .edit:         Image(systemName: "pencil")
        case .chevronDown:  Image(systemName: "chevron.down")
        case .briefCase:    Image(systemName: "briefcase.fill")
        }
    }
}

#Preview {
    AIButton(image: .empty, action: nil)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
