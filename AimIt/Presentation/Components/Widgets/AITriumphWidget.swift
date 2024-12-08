//
//  AIAchievementsWidgetView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import SwiftUI

struct AITriumphWidget: View {
    
    var body: some View {
        VStack{
            HStack(spacing: 5){
                Image(systemName: "rosette")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                
                Text("Triumphs")
                    .font(.system(.headline, design: .rounded, weight: .bold))
                
                Spacer()
            }
            
            HStack{
                Image("1stMilestoneTriumph")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                
                Text("First Milestone")
                    .font(.system(.subheadline, design: .rounded, weight: .bold))
                    .lineLimit(1)
                
                Spacer()
            }
            Spacer()
        }
        .foregroundStyle(.aiLabel)
        .padding(.horizontal, 10)
        .padding(.vertical, 20)
        .frame(maxWidth: (UIConstants.screenWidth / 2) - 20)
        .frame(height: UIConstants.screenHeight / 3.5)
        .background(Color.aiBlue, in: .rect(cornerRadius: 30))
        .padding(.trailing, 20)
    }
}

#Preview {
    AITriumphWidget()
}
