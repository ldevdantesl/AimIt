//
//  AIMilestoneBreakdownChart.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 16.01.2025.
//

import SwiftUI
import Charts

struct AIMilestoneBreakdownChart: View {
    private let analyticsVM: AnalyticsViewModel
    private let workspace: Workspace
    
    init(analyticsVM: AnalyticsViewModel, workspace: Workspace) {
        self.analyticsVM = analyticsVM
        self.workspace = workspace
    }
    
    @State private var milestoneMonthlyData: [AnalyticsMonthlyData] = []
    @State private var completedMilestoneMonthlyData: [AnalyticsMonthlyData] = []
    
    var body: some View {
        VStack{
            AIInfoField(title: "Milestones", info: nil)
            
            VStack {
                Chart {
                    ForEach(milestoneMonthlyData) { data in
                        PointMark(
                            x: .value("Month", data.date, unit: .month),
                            y: .value("Total Milestones", data.count)
                        )
                        .foregroundStyle(Color.aiBeige)
                    }
                    
                    
                    ForEach(completedMilestoneMonthlyData) { data in
                        PointMark(
                            x: .value("Month", data.date, unit: .month),
                            y: .value("Completed Milestones", data.count)
                        )
                        .foregroundStyle(Color.accentColor)
                        .cornerRadius(5)
                    }
                    
                    RuleMark(y: .value("Some Value", 5))
                        .foregroundStyle(.aiBeige)
                        .lineStyle(.init(lineWidth: 1, dash: [2,2]))
                        .annotation(alignment: .trailing) {
                            Text("Optimal Quantity")
                                .font(.system(.caption2, design: .rounded, weight: .light))
                                .foregroundStyle(.aiSecondary2)
                        }
                }
                .chartXAxis {
                    AxisMarks(values: milestoneMonthlyData.map(\.date)) { _ in
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
                        AxisTick()
                        AxisValueLabel()
                            .foregroundStyle(.aiBeige)
                            .font(.system(size: 11, weight: .light, design: .rounded))
                    }
                }
                .chartYScale(domain: ChartHelper.chartYScaleDomain(data: milestoneMonthlyData, incrementedBy: 11))
                .chartAppearence()
                
                HStack {
                    AIChartInfo(text: "Completed Milestones", shape: .circle, color: .accentColor)
                    
                    Spacer()
                    
                    AIChartInfo(text: "Total Milestones", shape: .circle, color: .aiBeige)
                }
                .padding(.horizontal, 20)
            }
        }
        .onAppear(perform: setup)
    }
    
    func setup() {
        DispatchQueue.main.async {
            withAnimation {
                self.milestoneMonthlyData = ChartHelper.mergeResultsWithDefaults(results: analyticsVM.calculateMonthlyDataForMilestones(in: self.workspace))
                
                self.completedMilestoneMonthlyData = ChartHelper.mergeResultsWithDefaults(results: analyticsVM.calculateMonthlyDataForCompletedMilestones(in: self.workspace))
            }
        }
    }
}

#Preview {
    AIMilestoneBreakdownChart(analyticsVM: DIContainer().makeAnalyticsViewModel(), workspace: .sample)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
