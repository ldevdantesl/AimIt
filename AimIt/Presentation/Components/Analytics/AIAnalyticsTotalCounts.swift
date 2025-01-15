//
//  AITotalMilestones.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 14.01.2025.
//

import Foundation
import SwiftUI

struct AIAnalyticsTotalCounts: View {
    private let analyticsVM: AnalyticsViewModel
    private let workspace: Workspace
    
    init(analyticsVM: AnalyticsViewModel, in workspace: Workspace) {
        self.analyticsVM = analyticsVM
        self.workspace = workspace
    }
    
    @State private var totalGoals: Double = 0
    @State private var totalMilestones: Double = 0
    
    var body: some View {
        VStack(spacing: 10){
            Text("Total Counts")
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .font(.system(.subheadline, design: .rounded, weight: .semibold))
                .foregroundStyle(.aiSecondary2)
                .padding(.horizontal, 15)
            
            HStack{
                Gauge(value: totalGoals, in: 0...totalMilestones + 5) {
                    Text("Goals")
                        .font(.system(size: 9, weight: .semibold, design: .rounded))
                        .foregroundStyle(.aiSecondary2)
                } currentValueLabel: {
                    Text(Int(totalGoals).description)
                        .foregroundStyle(.aiLabel)
                }
                .gaugeStyle(.accessoryCircular)
                .frame(width: 129, height: 120)
                .scaleEffect(2)
                .tint(.accent)
                
                Spacer()
                    .frame(width: UIConstants.halfWidth / 3)
                
                Gauge(value: totalMilestones, in: 0...totalMilestones + 5) {
                    Text("Miles")
                        .font(.system(size: 9, weight: .semibold, design: .rounded))
                        .foregroundStyle(.aiSecondary2)
                } currentValueLabel: {
                    Text(Int(totalMilestones).description)
                        .foregroundStyle(.aiLabel)
                }
                .gaugeStyle(.accessoryCircular)
                .frame(width: 120, height: 120)
                .scaleEffect(2)
                .tint(.accent)
            }
            .frame(height: 120)
            .padding(.horizontal, 20)
        }
        .onAppear(perform: setup)
        .animation(.easeInOut(duration: 1), value: totalMilestones)
        .animation(.easeInOut(duration: 1), value: totalGoals)
    }
    
    private func setup() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation {
                self.totalGoals = Double(analyticsVM.fetchTotalGoals(in: workspace))
                self.totalMilestones = Double(analyticsVM.fetchTotalMilestones(in: workspace))
            }
        }
    }
}

#Preview {
    AIAnalyticsTotalCounts(analyticsVM: DIContainer().makeAnalyticsViewModel(), in: .sample)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(DIContainer().makeMilestoneViewModel())
}
