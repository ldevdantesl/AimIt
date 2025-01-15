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
    
    var body: some View {
        VStack(spacing: 20){
            AIInfoField(
                title: "Completed",
                titleFontStyle: .subheadline,
                info: "Goals & Milestones",
                infoFontStyle: .headline,
                swappedPostions: true
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
                    }
                    .gaugeStyle(AccessoryCircularCapacityGaugeStyle())
                    .frame(width: 120, height: 120)
                    .scaleEffect(2)
                    .tint(.accent)
                }
                
                Spacer()
                
                VStack{
                    Gauge(value: completedMilestones, in: 0...totalMilestones) { } currentValueLabel: {
                        Text(Int(completedMilestones).description)
                            .foregroundStyle(.aiLabel)
                    }
                    .gaugeStyle(AccessoryCircularCapacityGaugeStyle())
                    .frame(width: 120, height: 120)
                    .scaleEffect(2)
                    .tint(.accent)
                    
                    VStack(alignment: .trailing) {
                        Text("Milestones")
                            .font(.system(.headline, design: .rounded, weight: .semibold))
                            .foregroundStyle(.aiBeige)
                        
                        Text("Total: \(Int(totalMilestones).description)")
                            .font(.system(.subheadline, design: .rounded, weight: .semibold))
                            .foregroundStyle(.aiSecondary2)
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .onAppear(perform: setup)
        .animation(.linear(duration: 1), value: completedGoals)
        .animation(.linear(duration: 1), value: completedMilestones)
    }
    
    private func setup() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation {
                self.completedGoals = Double(analyticsVM.fetchCompletedGoals(in: workspace).count)
                self.completedMilestones = Double(analyticsVM.fetchCompletedMilestones(in: workspace).count)
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
