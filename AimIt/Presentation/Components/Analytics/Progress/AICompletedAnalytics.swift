//
//  AICompletedAnalytics.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 14.01.2025.
//

import SwiftUI

struct AICompletedAnalytics: View {
    private let analyticsVM: AnalyticsViewModel
    private let workspace: Workspace
    
    private var totalGoals: Double
    private var totalMilestones: Double
    
    init(analyticsVM: AnalyticsViewModel, in workspace: Workspace) {
        self.analyticsVM = analyticsVM
        self.workspace = workspace
        self.totalGoals = Double(analyticsVM.fetchTotalGoals(in: workspace))
        self.totalMilestones = Double(analyticsVM.fetchTotalMilestones(in: workspace))
    }

    @State private var completedGoals: Double = 0
    @State private var completedMilestones: Double = 0
    
    @State private var targetGoals: Double = 0
    @State private var targetMilestones: Double = 0
    
    var body: some View {
        VStack(spacing: 10){
            AIInfoField(
                title: "Completed Goals & Milestones",
                titleFontStyle: .subheadline,
                info: nil
            )
            
            HStack{
                VStack(alignment:.leading, spacing: 5){
                    VStack(alignment: .leading) {
                        Text("Goals")
                            .font(.system(.headline, design: .rounded, weight: .semibold))
                            .foregroundStyle(.aiBeige)
                        
                        Text("Total: \(Int(totalGoals).description)")
                            .font(.system(.subheadline, design: .rounded, weight: .semibold))
                            .foregroundStyle(.aiSecondary2)
                    }
                    
                    Gauge(value: completedGoals, in: 0...totalGoals) { } currentValueLabel: {
                        Text(Int(completedGoals).description)
                            .foregroundStyle(.aiLabel)
                            .contentTransition(.numericText())
                    }
                    .gaugeStyle(AccessoryCircularCapacityGaugeStyle())
                    .frame(width: 120, height: 120)
                    .scaleEffect(2)
                    .tint(Color.accent.gradient)
                }
                
                Spacer()
                
                VStack{
                    VStack(alignment: .trailing) {
                        Text("Milestones")
                            .font(.system(.headline, design: .rounded, weight: .semibold))
                            .foregroundStyle(.aiBeige)
                        
                        Text("Total: \(Int(totalMilestones).description)")
                            .font(.system(.subheadline, design: .rounded, weight: .semibold))
                            .foregroundStyle(.aiSecondary2)
                    }
                    
                    Gauge(value: completedMilestones, in: 0...totalMilestones) { } currentValueLabel: {
                        Text(Int(completedMilestones).description)
                            .foregroundStyle(.aiLabel)
                            .contentTransition(.numericText())
                    }
                    .gaugeStyle(AccessoryCircularCapacityGaugeStyle())
                    .frame(width: 120, height: 120)
                    .scaleEffect(2)
                    .tint(Color.accent.gradient)
                }
            }
            .padding(.horizontal, 20)
        }
        .onAppear(perform: setup)
        .animation(.linear, value: completedGoals)
        .animation(.linear, value: completedMilestones)
    }
    
    private func setup() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            let fetchedGoals = Double(analyticsVM.fetchCompletedGoals(in: workspace).count)
            let fetchedMilestones = Double(analyticsVM.fetchCompletedMilestones(in: workspace).count)
            
            targetGoals = fetchedGoals
            targetMilestones = fetchedMilestones
            
            Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                let stepGoals = 0.1 * Double(completedGoals + 1)
                let stepMilestones = 0.1 * Double(completedMilestones + 1)
                var goalsDone = false
                var milestonesDone = false
                
                if completedGoals < targetGoals {
                    completedGoals = min(completedGoals + stepGoals, targetGoals)
                } else {
                    goalsDone = true
                }
                
                if completedMilestones < targetMilestones {
                    completedMilestones = min(completedMilestones + stepMilestones, targetMilestones)
                } else {
                    milestonesDone = true
                }
                
                if goalsDone && milestonesDone {
                    timer.invalidate()
                }
            }
        }
    }
}

#Preview {
    AICompletedAnalytics(analyticsVM: DIContainer().makeAnalyticsViewModel(), in: .sample)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(DIContainer().makeMilestoneViewModel())
}
