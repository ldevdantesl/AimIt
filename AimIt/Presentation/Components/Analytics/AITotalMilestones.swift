//
//  AITotalMilestones.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 14.01.2025.
//

import Foundation
import SwiftUI

struct AITotalMilestones: View {
    @EnvironmentObject var milestoneVM: MilestoneViewModel
    
    private var totalMilestones: Int {
        milestoneVM.fetchAllMilestones().count
    }
    
    var body: some View {
        VStack{
            AIInfoField(title: "Milestones", info: nil)
         
            Gauge(value: Double(totalMilestones), in: 0...Double(totalMilestones)) {
         
            } currentValueLabel: {
                Text(Double(totalMilestones).description)
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text(Double(totalMilestones).description)
            }
            .padding(.horizontal, 20)
            .gaugeStyle(.accessoryCircular)
            .tint(.accent)
            .scaleEffect(2)
        }
    }
}

#Preview {
    AITotalMilestones()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(DIContainer().makeMilestoneViewModel())
}
