//
//  AIMilestoneView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import Foundation
import SwiftUI

struct AIMilestonesCardView: View {
    @EnvironmentObject var milestoneVM: MilestoneViewModel
    @State var milestone: Milestone
    
    var body: some View {
        HStack(spacing: 15){
            HStack{
                Image(systemName: milestone.systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                Text(milestone.desc)
                    .font(.system(.headline, design: .rounded, weight: .semibold))
                    .lineLimit(1)
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .foregroundStyle(milestone.isCompleted ? .aiLabel : .aiSecondary2)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(milestone.isCompleted ? .green : .aiSecondary, in: .rect(cornerRadius: 15))
            
            Button{
                milestone.isCompleted.toggle()
                milestoneVM.toggleMilestoneCompletion(milestone)
            } label: {
                RoundedRectangle(cornerRadius: 15)
                    .fill(milestone.isCompleted ? .green : .aiSecondary)
                    .frame(width: 50)
                    .overlay {
                        Image(systemName: milestone.isCompleted ? "checkmark.circle.fill" : "circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(milestone.isCompleted ? .aiLabel : .aiSecondary2)
                    }
            }
        }
        .animation(.bouncy, value: milestone)
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .padding(.horizontal, 20)
    }
}

#Preview {
    AIMilestonesCardView(milestone: Milestone.sample)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(DIContainer().makeMilestoneViewModel())
}
