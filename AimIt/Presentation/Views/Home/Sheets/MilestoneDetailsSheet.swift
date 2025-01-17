//
//  MilestoneDetailsView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.01.2025.
//

import SwiftUI

struct MilestoneDetailsSheet: View {
    @EnvironmentObject var milestoneVM: MilestoneViewModel
    @EnvironmentObject var coordinator: HomeCoordinator
    @Binding var milestone: Milestone
    private let togglingEnabled: Bool
    
    init(milestone: Binding<Milestone>, togglingEnabled: Bool) {
        self._milestone = milestone
        self.togglingEnabled = togglingEnabled
    }
    
    var body: some View {
        ScrollView{
            HStack{
                Image(systemName: milestone.systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color.aiBeige)
                
                Text(milestone.isCompleted ? "Completed" : "Not Completed")
                    .font(.system(.title3, design: .rounded, weight: .bold))
                    .foregroundStyle(.aiBeige)
                    .lineLimit(1)
                
                Spacer()
                
                if let deadline = milestone.dueDate {
                    Text(DeadlineFormatter.formatToDayMonth(deadline))
                        .font(.system(.title3, design: .rounded, weight: .bold))
                        .foregroundStyle(.aiBeige)
                        .lineLimit(1)
                }
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(
                Color.accentColor,
                in:.rect(cornerRadii: .init(bottomLeading: 15, bottomTrailing: 15))
            )
            
            Spacer(minLength: 20)
            
            HStack{
                Button(action: toggleMilestone){
                    Image(systemName: milestone.isCompleted ? "checkmark.circle" : "circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(milestone.isCompleted ? Color.accentColor : Color.aiSecondary2)
                }
                .disabled(!togglingEnabled)
                
                Text(milestone.desc)
                    .foregroundStyle(.aiLabel)
                    .font(.system(.title3, design: .rounded, weight: .semibold))
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .ignoresSafeArea(.container, edges: .top)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
    }
    
    private func toggleMilestone() {
        DispatchQueue.main.async {
            withAnimation {
                milestone.isCompleted.toggle()
                milestone.completedAt = milestone.isCompleted ? Date() : nil
                milestoneVM.toggleMilestoneCompletion(milestone)
                coordinator.dismissSheet()
            }
        }
    }
}

#Preview {
    MilestoneDetailsSheet(milestone: .constant(.sample), togglingEnabled: false)
        .environmentObject(DIContainer().makeMilestoneViewModel())
        .environmentObject(HomeCoordinator())
}
