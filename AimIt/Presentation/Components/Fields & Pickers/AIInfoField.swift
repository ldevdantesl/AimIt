//
//  AIInfoField.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import Foundation
import SwiftUI

struct AIInfoField: View {
    private let title: String?
    private let titleFontStyle: Font.TextStyle
    private let titleForeColor: Color

    private let info: String
    private let infoFontStyle: Font.TextStyle
    private let infoForeColor: Color
    private let infoFontDesign: Font.Design
    
    private let buttonSystemImage: String?
    private let buttonColor: Color?
    private let buttonSize: CGFloat?
    private let buttonAction: (() -> ())
    
    /// Default Initiializer without button in the trailing.
    init(
        title: String?,
        titleFontStyle: Font.TextStyle = .subheadline,
        titleForeColor: Color = .aiSecondary2,
        info: String,
        infoFontStyle: Font.TextStyle = .title2,
        infoForeColor: Color = .aiLabel,
        infoFontDesign: Font.Design = .default
    ) {
        self.title = title
        self.titleFontStyle = titleFontStyle
        self.titleForeColor = titleForeColor
        self.info = info
        self.infoFontStyle = infoFontStyle
        self.infoForeColor = infoForeColor
        self.infoFontDesign = infoFontDesign
        self.buttonSystemImage = nil
        self.buttonColor = nil
        self.buttonSize = nil
        self.buttonAction = {}
    }
    
    /// Initializer with the trailing button and action on it.
    init(
        title: String?,
        titleFontStyle: Font.TextStyle = .headline,
        titleForeColor: Color = .aiSecondary2,
        info: String,
        infoFontStyle: Font.TextStyle = .title2,
        infoForeColor: Color = .aiLabel,
        infoFontDesign: Font.Design = .default,
        buttonSystemImage: String,
        buttonColor: Color = .aiSecondary2,
        buttonSize: CGFloat = 20,
        buttonAction: @escaping (() -> ()) = {}
    ) {
        self.title = title
        self.titleFontStyle = titleFontStyle
        self.titleForeColor = titleForeColor
        self.info = info
        self.infoFontStyle = infoFontStyle
        self.infoForeColor = infoForeColor
        self.infoFontDesign = infoFontDesign
        self.buttonSystemImage = buttonSystemImage
        self.buttonColor = buttonColor
        self.buttonSize = buttonSize
        self.buttonAction = buttonAction
    }
    
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                if let title {
                    Text(title)
                        .font(.system(titleFontStyle, design: .rounded, weight: .light))
                        .foregroundStyle(titleForeColor)
                }
                    
                Text("\(info)")
                    .font(.system(infoFontStyle, design: .rounded, weight: .semibold))
                    .foregroundStyle(infoForeColor)
                    .fontDesign(infoFontDesign)
            }
            Spacer()
            
            if let buttonSize           = buttonSize,
               let buttonSystemImage    = buttonSystemImage,
               let buttonColor          = buttonColor
            {
                Button(action: buttonAction) {
                    Image(systemName: buttonSystemImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: buttonSize, height: buttonSize)
                        .foregroundStyle(buttonColor)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    AIInfoField(title: "Title", info: "Some info")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
