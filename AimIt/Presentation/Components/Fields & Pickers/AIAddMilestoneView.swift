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
    
    init(goalTitle: String, milestones: Binding<[Milestone]>) {
        self.goalTitle = goalTitle
        self._milestones = milestones
    }
    
    var body: some View {
        VStack{
            HStack{
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
            
            AIMilestoneList(milestones: $milestones)
        }
        .padding(.horizontal, 20)
        .sheet(isPresented: $isAddingMilestone) {
            CreateMilestoneView(goalTitle: goalTitle, milestones: $milestones)
        }
    }
}

#Preview {
    AIAddMilestoneView(goalTitle: "Some ", milestones: .constant(Milestone.sampleMilestones))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
