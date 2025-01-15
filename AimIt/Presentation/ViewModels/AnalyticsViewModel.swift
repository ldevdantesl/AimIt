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
        fetchMilestonesCompletedWithinWeek: AnalyticsFetchCompletedMilestonesWithinWeekUseCase
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
    }
    
    // MARK: - TOTAL COUNT FUNCTIONS
    public func fetchTotalGoals(in workspace: Workspace) -> Int {
        do {
            return try fetchTotalGoalsUseCase.execute(in: workspace)
        } catch {
            errorMsg = "Error fetching total goals: \(error.localizedDescription)"
            return 0
        }
    }
    
    public func fetchTotalMilestones(in workspace: Workspace) -> Int {
        do {
            return try fetchTotalMilestonesUseCase.execute(in: workspace)
        } catch {
            errorMsg = "Error fetching total milestones: \(error.localizedDescription)"
            return 0
        }
    }
    
    // MARK: - COMPLETED & UNCOMPLETED FUNCTIONS
    public func fetchCompletedGoals(in workspace: Workspace) -> [Goal] {
        do {
            return try fetchCompletedGoalsUseCase.execute(in: workspace)
        } catch {
            errorMsg = "Error fetching completed goals: \(error.localizedDescription)"
            return []
        }
    }
    
    public func fetchUncompletedGoals(in workspace: Workspace) -> [Goal] {
        do {
            return try fetchUncompletedGoalsUseCase.execute(in: workspace)
        } catch {
            errorMsg = "Error fetching uncompleted goals: \(error.localizedDescription)"
            return []
        }
    }
    
    public func fetchCompletedMilestones(in workspace: Workspace) -> [Milestone] {
        do {
            return try fetchCompletedMilestonesUseCase.execute(in: workspace)
        } catch {
            errorMsg = "Error fetching completed milestones: \(error.localizedDescription)"
            return []
        }
    }
    
    public func fetchUncompletedMilestones(in workspace: Workspace) -> [Milestone] {
        do {
            return try fetchUncompletedMilestonesUseCase.execute(in: workspace)
        } catch {
            errorMsg = "Error fetching uncompleted milestones: \(error.localizedDescription)"
            return []
        }
    }
    
    // MARK: - AVERAGE FUNCTIONS
    public func averageGoalCompletionTime(in workspace: Workspace) -> TimeInterval {
        do {
            return try averageGoalCompletionTimeUseCase.execute(in: workspace)
        } catch {
            errorMsg = "Error fetching average goal completion time: \(error.localizedDescription)"
            return .zero
        }
    }
    
    public func averageMilestoneCompletionTime(in workspace: Workspace) -> TimeInterval {
        do {
            return try averageMilestoneCompletionTimeUseCase.execute(in: workspace)
        } catch {
            errorMsg = "Error fetching average milestone completion time: \(error.localizedDescription)"
            return .zero
        }
    }
    
    // MARK: - TIMEBASED FUNCTIONS
    public func fetchGoalsCompletedWithinMonth(in workspace: Workspace) -> [Goal] {
        do {
            return try fetchGoalsCompletedWithinMonthUseCase.execute(in: workspace)
        } catch {
            errorMsg = "Error fetching completed goals within month: \(error.localizedDescription)"
            return []
        }
    }
    
    public func fetchMilestonesCompletedWithinWeek(in workspace: Workspace) -> [Milestone] {
        do {
            return try fetchMilestonesCompletedWithinWeek.execute(in: workspace)
        } catch {
            errorMsg = "Error fetching completed milestones within week: \(error.localizedDescription)"
            return []
        }
    }
}
