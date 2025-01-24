//
//  AIChartInfo.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 16.01.2025.
//

import SwiftUI

struct AIChartInfo: View {
    
    enum AIChartInfoShapes {
        case circle
        case dashedLine
        case line
    }
    
    private let text: String
    private let shape: AIChartInfoShapes
    private let color: Color
    
    init(
        text: String,
        shape: AIChartInfoShapes,
        color: Color
    ) {
        self.text = text
        self.shape = shape
        self.color = color
    }
    
    var body: some View {
        HStack{
            if shape == .dashedLine {
                Rectangle()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [2, 2]))
                    .frame(width: 20, height: 1)
                    .foregroundColor(color)
            } else if shape == .line {
                Image(systemName: "minus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(color)
            } else {
                Image(systemName: "circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 10)
                    .foregroundStyle(color)
            }
            
            Text(text)
                .font(.system(.caption2, design: .rounded, weight: .semibold))
                .foregroundStyle(.aiSecondary2)
        }
    }
}

#Preview {
    AIChartInfo(text: "Preferred Amount", shape: .line, color: .aiOrange)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
