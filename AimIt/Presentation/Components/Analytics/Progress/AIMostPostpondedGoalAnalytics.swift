//
//  AIMostPostpondedGoalAnalytics.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 16.01.2025.
//

import SwiftUI

struct AIMostPostpondedGoalAnalytics: View {
    
    private let analyticsVM: AnalyticsViewModel
    private let workspace: Workspace
    
    init(analyticsVM: AnalyticsViewModel, workspace: Workspace) {
        self.analyticsVM = analyticsVM
        self.workspace = workspace
    }
    
    @State private var mostPostpondedGoal: Goal?
    
    var body: some View {
        VStack {
            AIInfoField(
                title: "Most postponded goal",
                info: nil
            )
            
            if let goal = mostPostpondedGoal {
                HStack{
                    AIMiniGoalCard(goal: goal)
                    
                    Text(goal.deadlineChanges.description)
                        .font(.system(size: 70, weight: .semibold, design: .rounded))
                        .foregroundStyle(.aiBeige)
                        .padding(.trailing, 20)
                        .contentTransition(.numericText())
                }
            } else {
                HStack{
                    Image(ImageNames.noPostpondedGoal)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                    
                    Text("Hoorayy. You don't have postponded goal")
                        .font(.system(.footnote, design: .rounded, weight: .semibold))
                        .foregroundStyle(.aiSecondary2)
                        .lineLimit(2)
                        .frame(width: UIConstants.halfWidth)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .onAppear(perform: setup)
    }
    
    private func setup() {
        DispatchQueue.main.async {
            withAnimation {
                self.mostPostpondedGoal = analyticsVM.fetchMostPostpondedGoal(in: workspace)
            }
        }
    }
}

#Preview {
    AIMostPostpondedGoalAnalytics(
        analyticsVM: DIContainer().makeAnalyticsViewModel(),
        workspace: .sample
    )
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.aiBackground)
}
