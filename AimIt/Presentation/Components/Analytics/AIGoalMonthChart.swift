//
//  AIMonthChart.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 15.01.2025.
//

import Foundation
import SwiftUI
import Charts

struct AIGoalMonthChart: View {
    private let analyticsVM: AnalyticsViewModel
    private let workspace: Workspace
    
    init(analyticsVM: AnalyticsViewModel, workspace: Workspace) {
        self.analyticsVM = analyticsVM
        self.workspace = workspace
    }
    
    @State private var goalsMonthlyData: [AnalyticsMonthlyData] = []
    @State private var completedGoalsMonthlyData: [AnalyticsMonthlyData] = []
    @State private var milestonesMonthlyData: [AnalyticsMonthlyData] = []
    
    var body: some View {
        VStack{
            AIInfoField(
                title: "Charts",
                titleFontStyle: .subheadline,
                info: "Goal deadlines of \(Date().formatted(.dateTime.year()))",
                swappedPostions: true
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
            .chartXAxis {
                AxisMarks(values: goalsMonthlyData.map(\.date)) { _ in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(format: .dateTime.month(.abbreviated))
                        .foregroundStyle(.aiBeige)
                        .font(.system(size: 11, weight: .light, design: .rounded))
                }
            }
            .chartYAxis {
                AxisMarks{
                    AxisGridLine()
                    AxisValueLabel()
                        .foregroundStyle(.aiBeige)
                        .font(.system(size: 11, weight: .light, design: .rounded))
                }
            }
            .chartYScale(domain: 0...ChartHelper.getMaximumCountValue(from: goalsMonthlyData) + 1)
            .frame(height: 200)
            .padding(.vertical, 10)
            .padding(.top, 5)
            .padding(.horizontal, 10)
            .background(Color.aiSecondary, in: .rect(cornerRadius: 15))
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
            
            AIInfoField(
                title: "Goal completions of \(Date().formatted(.dateTime.year()))",
                titleFontStyle: .subheadline,
                info: nil
            )
            
            Chart {
                ForEach(completedGoalsMonthlyData) { data in
                    AreaMark(
                        x: .value("Month", data.date, unit: .month),
                        y: .value("Total Goals", data.count)
                    )
                    .foregroundStyle(Color.accentColor)
                    .cornerRadius(5)
                }
            }
            .chartXAxis {
                AxisMarks(values: completedGoalsMonthlyData.map(\.date)) { _ in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(format: .dateTime.month(.abbreviated))
                        .foregroundStyle(.aiBeige)
                        .font(.system(size: 11, weight: .light, design: .rounded))
                }
            }
            .chartYAxis {
                AxisMarks{
                    AxisGridLine()
                    AxisValueLabel()
                        .foregroundStyle(.aiBeige)
                        .font(.system(size: 11, weight: .light, design: .rounded))
                }
            }
            .chartYScale(domain: 0...ChartHelper.getMaximumCountValue(from: completedGoalsMonthlyData) + 1)
            .frame(height: 200)
            .padding(.vertical, 10)
            .padding(.top, 5)
            .padding(.horizontal, 10)
            .background(Color.aiSecondary, in: .rect(cornerRadius: 15))
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
        }
        .onAppear(perform: setup)
    }
    
    private func setup() {
        DispatchQueue.main.async {
            withAnimation {
                self.goalsMonthlyData = ChartHelper.mergeResultsWithDefaults(
                    results: analyticsVM.calculateMonthlyDataForGoals(in: workspace)
                )
                
                self.completedGoalsMonthlyData = ChartHelper.mergeResultsWithDefaults(
                    results: analyticsVM.calculateMonthlyDataForCompletedGoals(in: workspace)
                )
                
                self.milestonesMonthlyData = ChartHelper.mergeResultsWithDefaults(
                    results: analyticsVM.calculateMonthlyDataForMilestones(in: workspace)
                )
            }
        }
    }
}

#Preview {
    AIGoalMonthChart(analyticsVM: DIContainer().makeAnalyticsViewModel(), workspace: .sample)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
