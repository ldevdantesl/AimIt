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
    }

    let title: String?
    let image: ImageType
    let action: (() -> ())?
    let backColor: Color
    let foreColor: Color
    
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
    
    init(title: String, action: (() -> ())? = nil) {
        self.title = title
        self.action = action
        self.image = .empty
        self.backColor = .accent
        self.foreColor = .aiLabel
    }
    
    var body: some View {
        Button{
            action?()
        } label: {
            if let title = title {
                Text(title)
                    .font(.system(.headline, design: .rounded, weight: .semibold))
                    .foregroundStyle(foreColor)
                    .frame(minWidth: UIConstants.screenWidth - 40, maxWidth: .infinity)
                    .frame(height: 50)
                    .background(backColor, in: .rect(cornerRadius: 25))
                    .shadow(color: Color.aiBlack.opacity(0.3), radius: 15, x: 0, y: 0)
                    .shadow(color: Color.aiBlack.opacity(0.2), radius: 30, x: 0, y: 0) //
                    .padding(.horizontal, 20)
            } else {
                ZStack {
                    if image != .empty{
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
                            .frame(width: 25, height: 20)
                            .zIndex(2)
                            .foregroundStyle(foreColor)
                    }
                }
                .frame(width: 45, height: 45)
            }
        }
    }
    
    
    func makeImage() -> Image {
        switch image {
        case .back:
            return Image(systemName: "chevron.left")
        case .ellipsis:
            return Image(systemName: "ellipsis")
        case .bell:
            return Image(systemName: "bell")
        case .plus:
            return Image(systemName: "plus")
        case .xmark:
            return Image(systemName: "xmark")
        case .empty:
            return Image(systemName: "circle.fill")
        case .ava:
            return Image(systemName: "person.fill")
        case .edit:
            return Image(systemName: "pencil")
        }
    }
}

#Preview {
    AIButton(image: .empty, action: nil)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
