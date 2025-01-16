//
//  AnalyticsViewModel.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 14.01.2025.
//

import Foundation
import SwiftUI

@MainActor
final class AnalyticsViewModel: ObservableObject {
    @Published var errorMsg: String?
    
    private let averageGoalCompletionTimeUseCase: AnalyticsAverageGoalCompletionTimeUseCase
    private let averageMilestoneCompletionTimeUseCase: AnalyticsAverageMilestoneCompletionTimeUseCase
    
    private let fetchTotalGoalsUseCase: AnalyticsFetchTotalGoalsUseCase
    private let fetchTotalMilestonesUseCase: AnalyticsFetchTotalMilestonesUseCase
    
    private let fetchCompletedGoalsUseCase: AnalyticsFetchCompletedGoalsUseCase
    private let fetchUncompletedGoalsUseCase: AnalyticsFetchUncompletedGoalsUseCase
    
    private let fetchCompletedMilestonesUseCase: AnalyticsFetchCompletedMilestonesUseCase
    private let fetchUncompletedMilestonesUseCase: AnalyticsFetchUncompletedMilestonesUseCase
    
    private let fetchGoalsCompletedWithinMonthUseCase: AnalyticsFetchGoalsCompletedWithinMonthUseCase
    private let fetchMilestonesCompletedWithinWeek: AnalyticsFetchCompletedMilestonesWithinWeekUseCase
    
    private let calculateMonthlyDataForGoalsUseCase: AnalyticsCalculateMonthlyDataForGoalsUseCase
    private let calculateMonthlyDataForMilestonesUseCase: AnalyticsCalculateMonthlyDataForMilestonesUseCase
    private let calculateMonthlyDataForCompletedGoalsUseCase: AnalyticsCalculateMonthlyDataForCompletedGoalsUseCase
    private let calculateMonthlyDataForCompletedMilestonesUseCase: AnalyticsCalculateMonthlyDataForCompletedMilestonesUseCase
    
    init(
        averageGoalCompletionTimeUseCase: AnalyticsAverageGoalCompletionTimeUseCase,
        averageMilestoneCompletionTimeUseCase: AnalyticsAverageMilestoneCompletionTimeUseCase,
        fetchTotalGoalsUseCase: AnalyticsFetchTotalGoalsUseCase,
        fetchTotalMilestonesUseCase: AnalyticsFetchTotalMilestonesUseCase,
        fetchCompletedGoalsUseCase: AnalyticsFetchCompletedGoalsUseCase,
        fetchUncompletedGoalsUseCase: AnalyticsFetchUncompletedGoalsUseCase,
        fetchCompletedMilestonesUseCase: AnalyticsFetchCompletedMilestonesUseCase,
        fetchUncompletedMilestonesUseCase: AnalyticsFetchUncompletedMilestonesUseCase,
        fetchGoalsCompletedWithinMonthUseCase: AnalyticsFetchGoalsCompletedWithinMonthUseCase,
        fetchMilestonesCompletedWithinWeek: AnalyticsFetchCompletedMilestonesWithinWeekUseCase,
        calculateMonthlyDataForGoalsUseCase: AnalyticsCalculateMonthlyDataForGoalsUseCase,
        calculateMonthlyDataForMilestonesUseCase: AnalyticsCalculateMonthlyDataForMilestonesUseCase,
        calculateMonthlyDataForCompletedGoalsUseCase: AnalyticsCalculateMonthlyDataForCompletedGoalsUseCase,
        calculateMonthlyDataForCompletedMilestonesUseCase: AnalyticsCalculateMonthlyDataForCompletedMilestonesUseCase
    ) {
        self.averageGoalCompletionTimeUseCase = averageGoalCompletionTimeUseCase
        self.averageMilestoneCompletionTimeUseCase = averageMilestoneCompletionTimeUseCase
        self.fetchTotalGoalsUseCase = fetchTotalGoalsUseCase
        self.fetchTotalMilestonesUseCase = fetchTotalMilestonesUseCase
        self.fetchCompletedGoalsUseCase = fetchCompletedGoalsUseCase
        self.fetchUncompletedGoalsUseCase = fetchUncompletedGoalsUseCase
        self.fetchCompletedMilestonesUseCase = fetchCompletedMilestonesUseCase
        self.fetchUncompletedMilestonesUseCase = fetchUncompletedMilestonesUseCase
        self.fetchGoalsCompletedWithinMonthUseCase = fetchGoalsCompletedWithinMonthUseCase
        self.fetchMilestonesCompletedWithinWeek = fetchMilestonesCompletedWithinWeek
        self.calculateMonthlyDataForGoalsUseCase = calculateMonthlyDataForGoalsUseCase
        self.calculateMonthlyDataForMilestonesUseCase = calculateMonthlyDataForMilestonesUseCase
        self.calculateMonthlyDataForCompletedGoalsUseCase = calculateMonthlyDataForCompletedGoalsUseCase
        self.calculateMonthlyDataForCompletedMilestonesUseCase = calculateMonthlyDataForCompletedMilestonesUseCase
    }
    
    // MARK: - TOTAL COUNT FUNCTIONS
    public func fetchTotalGoals(in workspace: Workspace) -> Int {
        handleUseCase(in: workspace, defaultValue: 0, action: fetchTotalGoalsUseCase.execute)
    }
    
    public func fetchTotalMilestones(in workspace: Workspace) -> Int {
        handleUseCase(in: workspace, defaultValue: 0, action: fetchTotalMilestonesUseCase.execute)
    }
    
    // MARK: - COMPLETED & UNCOMPLETED FUNCTIONS
    public func fetchCompletedGoals(in workspace: Workspace) -> [Goal] {
        handleUseCase(in: workspace, defaultValue: [], action: fetchCompletedGoalsUseCase.execute)
    }
    
    public func fetchUncompletedGoals(in workspace: Workspace) -> [Goal] {
        handleUseCase(in: workspace, defaultValue: [], action: fetchUncompletedGoalsUseCase.execute)
    }
    
    public func fetchCompletedMilestones(in workspace: Workspace) -> [Milestone] {
        handleUseCase(in: workspace, defaultValue: [], action: fetchCompletedMilestonesUseCase.execute)
    }
    
    public func fetchUncompletedMilestones(in workspace: Workspace) -> [Milestone] {
        handleUseCase(in: workspace, defaultValue: [], action: fetchUncompletedMilestonesUseCase.execute)
    }
    
    // MARK: - AVERAGE FUNCTIONS
    public func averageGoalCompletionTime(in workspace: Workspace) -> TimeInterval {
        handleUseCase(in: workspace, defaultValue: .zero, action: averageGoalCompletionTimeUseCase.execute)
    }
    
    public func averageMilestoneCompletionTime(in workspace: Workspace) -> TimeInterval {
        handleUseCase(in: workspace, defaultValue: .zero, action: averageMilestoneCompletionTimeUseCase.execute)
    }
    
    // MARK: - TIMEBASED FUNCTIONS
    public func fetchGoalsCompletedWithinMonth(in workspace: Workspace) -> [Goal] {
        handleUseCase(in: workspace, defaultValue: [], action: fetchGoalsCompletedWithinMonthUseCase.execute)
    }
    
    public func fetchMilestonesCompletedWithinWeek(in workspace: Workspace) -> [Milestone] {
        handleUseCase(in: workspace, defaultValue: [], action: fetchMilestonesCompletedWithinWeek.execute)
    }
    
    // MARK: - MONTHLY DATA
    public func calculateMonthlyDataForGoals(in workspace: Workspace) -> [AnalyticsMonthlyData] {
        handleUseCase(in: workspace, defaultValue: [], action: calculateMonthlyDataForGoalsUseCase.execute)
    }
    
    public func calculateMonthlyDataForMilestones(in workspace: Workspace) -> [AnalyticsMonthlyData] {
        handleUseCase(in: workspace, defaultValue: [], action: calculateMonthlyDataForMilestonesUseCase.execute)
    }
    
    public func calculateMonthlyDataForCompletedGoals(in workspace: Workspace) -> [AnalyticsMonthlyData] {
        handleUseCase(in: workspace, defaultValue: [], action: calculateMonthlyDataForCompletedGoalsUseCase.execute)
    }
    
    public func calculateMonthlyDataForCompletedMilestones(in workspace: Workspace) -> [AnalyticsMonthlyData] {
        handleUseCase(in: workspace, defaultValue: [], action: calculateMonthlyDataForCompletedMilestonesUseCase.execute)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func handleUseCase<T>(in workspace: Workspace, defaultValue: T, action: (Workspace) throws -> T) -> T {
        do {
            return try action(workspace)
        } catch {
            errorMsg = "Error occurred: \(error.localizedDescription)"
            print(errorMsg ?? "")
            return defaultValue
        }
    }
}
