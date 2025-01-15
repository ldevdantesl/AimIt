//
//  AIMonthChart.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 15.01.2025.
//

import Foundation
import SwiftUI
import Charts

struct AIMonthChart: View {
    private let analyticsVM: AnalyticsViewModel
    private let workspace: Workspace
    
    init(analyticsVM: AnalyticsViewModel, workspace: Workspace) {
        self.analyticsVM = analyticsVM
        self.workspace = workspace
        self.goalsMonthlyData = ChartHelper.mergeResultsWithDefaults(results: analyticsVM.calculateMonthlyDataForGoals(in: workspace))
        self.milestonesMonthlyData = ChartHelper.mergeResultsWithDefaults(results: analyticsVM.calculateMonthlyDataForMilestones(in: workspace))
    }
    
    @State private var goalsMonthlyData: [AnalyticsMonthlyData] = []
    @State private var milestonesMonthlyData: [AnalyticsMonthlyData] = []
    
    var body: some View {
        VStack{
            AIInfoField(
                title: "Month Chart for \(Date().description.prefix(4))",
                titleFontStyle: .subheadline,
                info: nil
            )
            
            Chart {
                ForEach(goalsMonthlyData) { data in
                    BarMark(
                        x: .value("Month", data.date, unit: .month),
                        y: .value("Total Goals", data.count)
                    )
                    .foregroundStyle(Color.accentColor)
                    .cornerRadius(5)
                }
            }
            .frame(height: 200)
            .background(Color.aiSecondary)
            .padding(.horizontal, 20)
            .chartXAxis {
                AxisMarks(values: .stride(by: .month)) { value in
                    if let _ = value.as(Date.self) {
                        AxisValueLabel(format: .dateTime.month(.abbreviated))
                            .foregroundStyle(.aiBeige)
                    }
                }
            }
            .chartYScale(domain: 0...100)
        }
    }
}

#Preview {
    AIMonthChart(analyticsVM: DIContainer().makeAnalyticsViewModel(), workspace: .sample)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
