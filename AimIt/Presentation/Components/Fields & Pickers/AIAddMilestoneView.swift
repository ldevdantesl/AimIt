//
//  AIAddMilestoneFild.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct AIAddMilestoneView: View {
    @State private var isAddingMilestone: Bool = false
    @Binding var milestones: [Milestone]
    
    let goalTitle: String
    
    var body: some View {
        VStack{
            HStack(alignment: .bottom){
                Text("Milestones")
                    .font(.system(.headline, design: .rounded, weight: .light))
                    .foregroundStyle(.aiSecondary2)
                Spacer()
                
                AIButton(image: .plus, backColor: .accentColor, foreColor: .aiLabel) {
                    isAddingMilestone.toggle()
                }
            }
            Divider()
                .background(Color.aiLabel)
                .padding(.vertical, 10)
            
            AIMilestoneCreationList(milestones: $milestones)
        }
        .padding(.horizontal, 20)
        .sheet(isPresented: $isAddingMilestone) {
            HomeCreateMilestoneView(goalTitle: goalTitle, milestones: $milestones)
        }
    }
}

#Preview {
    AIAddMilestoneView(milestones: .constant(Milestone.sampleMilestones), goalTitle: "Some")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
