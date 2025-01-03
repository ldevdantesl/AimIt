//
//  AIAddMilestoneFild.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct CreateMilestoneView: View {
    @EnvironmentObject var coordinator: HomeCoordinator
    @Binding var milestones: [Milestone]
    
    let goalTitle: String
    
    @State private var onSheet: Bool = false
    
    var body: some View {
        VStack{
            HStack(alignment: .bottom){
                Text("Milestones")
                    .font(.system(.headline, design: .rounded, weight: .light))
                    .foregroundStyle(.aiSecondary2)
                Spacer()
                
                AIButton(
                    image: .plus,
                    backColor: .accentColor,
                    foreColor: .aiLabel,
                    action: { onSheet.toggle() }
                )
            }
            .padding(.horizontal, 20)
            Divider()
                .background(Color.aiLabel)
                .padding(.vertical, 10)
            
            AIMilestoneCreationList(milestones: $milestones)
        }
        .sheet(isPresented: $onSheet) {
            CreateMilestoneSheet(goalTitle: goalTitle, milestones: $milestones)
        }
    }
}

#Preview {
    CreateMilestoneView(milestones: .constant(Milestone.sampleMilestones), goalTitle: "Some")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(HomeCoordinator())
}
