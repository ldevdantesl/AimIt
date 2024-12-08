//
//  AIAddMilestoneFild.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct AIAddMilestoneField: View {
    var body: some View {
        VStack{
            HStack{
                Text("Milestones")
                    .font(.system(.headline, design: .rounded, weight: .light))
                    .foregroundStyle(.aiSecondary2)
                Spacer()
            }
            
            HStack{
                AIButton(image: .plus, backColor: .aiOrange, foreColor: .white) {
                    
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    AIAddMilestoneField()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
