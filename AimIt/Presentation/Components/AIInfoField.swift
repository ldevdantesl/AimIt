//
//  AIInfoField.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import Foundation
import SwiftUI

struct AIInfoField: View {
    let title: String
    let titleFontStyle: Font.TextStyle
    let titleForeColor: Color
    
    let info: String
    let infoFontStyle: Font.TextStyle
    let infoForeColor: Color
    
    let buttonSystemImage: String?
    let buttonColor: Color?
    let buttonSize: CGFloat?
    let buttonAction: (() -> ())
    
    init(
        title: String,
        titleFontStyle: Font.TextStyle = .subheadline,
        titleForeColor: Color = .aiSecondary2,
        info: String,
        infoFontStyle: Font.TextStyle = .title2,
        infoForeColor: Color = .aiLabel
    ) {
        self.title = title
        self.titleFontStyle = titleFontStyle
        self.titleForeColor = titleForeColor
        self.info = info
        self.infoFontStyle = infoFontStyle
        self.infoForeColor = infoForeColor
        self.buttonSystemImage = nil
        self.buttonColor = nil
        self.buttonSize = nil
        self.buttonAction = {}
    }
    
    init(
        title: String,
        titleFontStyle: Font.TextStyle = .headline,
        titleForeColor: Color = .aiSecondary2,
        info: String,
        infoFontStyle: Font.TextStyle = .title2,
        infoForeColor: Color = .aiLabel,
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
        self.buttonSystemImage = buttonSystemImage
        self.buttonColor = buttonColor
        self.buttonSize = buttonSize
        self.buttonAction = buttonAction
    }
    
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(title)
                    .font(.system(titleFontStyle, design: .rounded, weight: .light))
                    .foregroundStyle(titleForeColor)
                
                Text("\(info)")
                    .font(.system(infoFontStyle, design: .rounded, weight: .semibold))
                    .foregroundStyle(infoForeColor)
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
