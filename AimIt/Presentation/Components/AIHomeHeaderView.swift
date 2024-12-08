//
//  AIHomeHeaderView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import SwiftUI

struct AIHomeHeaderView: View {
    var body: some View {
        HStack{
            AIButton(image: .back)
            Spacer()
            
            VStack(alignment: .center) {
                Text("Good morning 🌥️")
                    .font(.system(.subheadline, design: .rounded, weight: .light))
                    .foregroundStyle(.aiSecondary2)
                
                Text("Buzurg Rahimzoda")
                    .font(.system(.headline, design: .rounded, weight: .semibold))
                    .foregroundStyle(.aiLabel)
            }
            
            Spacer()
            AIButton(image: .plus)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    AIHomeHeaderView()
}
