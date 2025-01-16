//
//  AIMonthChart.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 15.01.2025.
//

import Foundation
import SwiftUI
import Charts

struct AIGoalBreakdownCharts: View {
    private let analyticsVM: AnalyticsViewModel
    private let workspace: Workspace
    
    init(analyticsVM: AnalyticsViewModel, workspace: Workspace) {
        self.analyticsVM = analyticsVM
        self.workspace = workspace
    }
    
    @State private var goalsMonthlyData: [AnalyticsMonthlyData] = []
    @State private var completedGoalsMonthlyData: [AnalyticsMonthlyData] = []
    
    var body: some View {
        VStack{
            AIInfoField(
                title: "Charts",
                titleFontStyle: .subheadline,
                info: "Total Goals within month",
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
            .chartYScale(domain: ChartHelper.chartYScaleDomain(data: goalsMonthlyData))
            .chartAppearence()
            
            AIInfoField(
                title: "Total Goals completed within month",
                titleFontStyle: .subheadline,
                info: nil
            )
            
            VStack(alignment: .trailing){
                Chart {
                    ForEach(completedGoalsMonthlyData) { data in
                        AreaMark(
                            x: .value("Month", data.date, unit: .month),
                            y: .value("Total Goals", data.count)
                        )
                        .foregroundStyle(Color.accentColor)
                        .cornerRadius(5)
                        
                        RuleMark(y: .value("Preferred Value", 1))
                            .lineStyle(.init(lineWidth: 2, dash: [2, 2]))
                            .foregroundStyle(.aiBeige)
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
                .chartYScale(domain: ChartHelper.chartYScaleDomain(data: completedGoalsMonthlyData))
                .chartAppearence()
                
                AIChartInfo(text: "Preferred Amount", shape: .dashedLine, color: .aiBeige)
                    .padding(.horizontal, 20)
            }
        }
        .onAppear(perform: setup)
    }
    
    private func setup() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation {
                self.goalsMonthlyData = ChartHelper.mergeResultsWithDefaults(
                    results: analyticsVM.calculateMonthlyDataForGoals(in: workspace)
                )
                
                self.completedGoalsMonthlyData = ChartHelper.mergeResultsWithDefaults(
                    results: analyticsVM.calculateMonthlyDataForCompletedGoals(in: workspace)
                )
            }
        }
    }
}

#Preview {
    AIGoalBreakdownCharts(analyticsVM: DIContainer().makeAnalyticsViewModel(), workspace: .sample)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
