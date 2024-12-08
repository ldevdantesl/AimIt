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
                    .foregroundStyle(.aiLabel)
                Spacer()
            }
            .padding(.leading, 10)
            
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    AIAddMilestoneField()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
