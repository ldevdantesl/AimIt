//
//  AICompletedGoalsAnalytics.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 16.01.2025.
//

import SwiftUI

struct AICompletedGoalsAnalytics: View {
    
    private let analyticsVM: AnalyticsViewModel
    private let workspace: Workspace
    
    init(analyticsVM: AnalyticsViewModel, workspace: Workspace) {
        self.analyticsVM = analyticsVM
        self.workspace = workspace
    }
    
    @State private var completedGoalsWithinMonth: [Goal] = []
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        VStack(spacing: 10){
            AIInfoField(
                title: "Goals Completed within this month",
                info: nil
            )
            
            HStack{
                Text(completedGoalsWithinMonth.count.description)
                    .font(.system(size: 70, weight: .semibold, design: .rounded))
                    .foregroundStyle(.aiBeige)
                    .contentTransition(.numericText())
                
                if !completedGoalsWithinMonth.isEmpty {
                    TabView(selection: $selectedIndex) {
                        ForEach(0..<completedGoalsWithinMonth.count, id: \.self) { index in
                            AIMiniGoalCard(goal: completedGoalsWithinMonth[index])
                                .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .overlay(alignment: .trailing) {
                        if completedGoalsWithinMonth.count > 1 {
                            Button(action: increaseIndex){
                                Image(systemName: "chevron.right.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .opacity(selectedIndex == 0 ? 0.7 : 0)
                                    .padding(.trailing, 10)
                            }
                        }
                    }
                } else {
                    Spacer()
                        .frame(width: 20)
                    
                    HStack{
                        Image(ImageNames.noCompletedGoals)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                        
                        Text("No goals completed within this month")
                            .font(.system(.caption2, design: .rounded, weight: .semibold))
                            .foregroundStyle(.aiSecondary2)
                    }
                    .frame(width: UIConstants.halfWidth)
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 20)
        }
        .onAppear(perform: setup)
    }
    
    private func setup() {
        DispatchQueue.main.async {
            withAnimation {
                self.completedGoalsWithinMonth = analyticsVM.fetchGoalsCompletedWithinMonth(in: self.workspace)
            }
        }
    }
    
    private func increaseIndex() {
        withAnimation {
            self.selectedIndex += 1
        }
    }
}

#Preview {
    AICompletedGoalsAnalytics(
        analyticsVM: DIContainer().makeAnalyticsViewModel(), workspace: .sample
    )
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.aiBackground)
}
