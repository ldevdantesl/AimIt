//
//  AnalyticsRepositoryImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 14.01.2025.
//

import Foundation
import SwiftUI
import CoreData

enum AnalyticsRepositoryErrors: Error {
    case dateError
    case noDataFound
    
    var localizedDescription: String {
        switch self {
        case .dateError:
            return "Failed to calculate month range."
        case .noDataFound:
            return "No data found after fetching."
        }
    }
}

final class AnalyticsRepositoryImpl: AnalyticsRepository {
    private let CDStack: CoreDataStack
    
    init(CDStack: CoreDataStack) {
        self.CDStack = CDStack
    }
    
    // MARK: - GOALS
    func fetchTotalGoals(in workspace: Workspace) throws -> Int {
        let request: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        request.predicate = NSPredicate(format: "workspace.id == %@", workspace.id.uuidString)
        
        return try CDStack.viewContext.fetch(request).count
    }
    
    func fetchCompletedGoals(in workspace: Workspace) throws -> [Goal] {
        let request: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        let predicate1 = NSPredicate(format: "workspace.id == %@", workspace.id.uuidString)
        let predicate2 = NSPredicate(format: "isCompleted == %@", NSNumber(value: true))
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        
        return try CDStack.viewContext.fetch(request).map { GoalMapper.mapToDomain(from: $0) }
    }
    
    func fetchUncompletedGoals(in workspace: Workspace) throws -> [Goal] {
        let request: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        let predicate1 = NSPredicate(format: "workspace.id == %@", workspace.id.uuidString)
        let predicate2 = NSPredicate(format: "isCompleted == %@", NSNumber(value: false))
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        
        return try CDStack.viewContext.fetch(request).map { GoalMapper.mapToDomain(from: $0) }
    }
    
    // MARK: - GOAL TIMEBASED
    func averageGoalCompletionTime(in workspace: Workspace) throws -> TimeInterval {
        let request: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        
        let workspacePredicate = NSPredicate(format: "workspace.id == %@", workspace.id.uuidString)
        let completionPredicate = NSPredicate(format: "isCompleted == %@", NSNumber(value: true))
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [workspacePredicate, completionPredicate])
        
        let goals = try CDStack.viewContext.fetch(request)
        
        let totalCompletionTime = goals.compactMap { goal -> TimeInterval? in
            guard let completionDate = goal.completedAt else { return nil }
            return completionDate.timeIntervalSince(goal.createdAt)
        }.reduce(0, +)
        
        return goals.isEmpty ? 0 : totalCompletionTime / Double(goals.count)
    }
    
    func fetchGoalsCompletedWithinMonth(in workspace: Workspace) throws -> [Goal] {
        let request: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        
        let calendar = Calendar.current
        guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Date())),
              let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth) else {
            throw AnalyticsRepositoryErrors.dateError
        }
        
        let workspacePredicate = NSPredicate(format: "workspace.id == %@", workspace.id.uuidString)
        let completionStatusPredicate = NSPredicate(format: "isCompleted == %@", NSNumber(value: true))
        let dateRangePredicate = NSPredicate(
            format: "completedAt >= %@ AND completedAt <= %@",
            startOfMonth as NSDate,
            endOfMonth as NSDate
        )
    
        request.predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [
                workspacePredicate,
                completionStatusPredicate,
                dateRangePredicate]
        )

        return try CDStack.viewContext.fetch(request).map { GoalMapper.mapToDomain(from: $0) }
    }
    
    // MARK: - MILESTONES
    func fetchTotalMilestones(in workspace: Workspace) throws -> Int {
        let request: NSFetchRequest<MilestoneEntity> = MilestoneEntity.fetchRequest()
        request.predicate = NSPredicate(format: "goal.workspace.id == %@", workspace.id.uuidString)
        
        return try CDStack.viewContext.fetch(request).count
    }
    
    func fetchCompletedMilestones(in workspace: Workspace) throws -> [Milestone] {
        let request: NSFetchRequest<MilestoneEntity> = MilestoneEntity.fetchRequest()
        let predicate1 = NSPredicate(format: "goal.workspace.id == %@", workspace.id.uuidString)
        let predicate2 = NSPredicate(format: "isCompleted == %@", NSNumber(value: true))
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        
        return try CDStack.viewContext.fetch(request).map { MilestoneMapper.toDomain($0) }
    }
    
    func fetchUncompletedMilestones(in workspace: Workspace) throws -> [Milestone] {
        let request: NSFetchRequest<MilestoneEntity> = MilestoneEntity.fetchRequest()
        let predicate1 = NSPredicate(format: "goal.workspace.id == %@", workspace.id.uuidString)
        let predicate2 = NSPredicate(format: "isCompleted == %@", NSNumber(value: false))
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        
        return try CDStack.viewContext.fetch(request).map { MilestoneMapper.toDomain($0) }
    }
    
    // MARK: - MILESTONE TIMEBASED
    func fetchCompletedMilestonesWithinWeek(in workspace: Workspace) throws -> [Milestone] {
        let request: NSFetchRequest<MilestoneEntity> = MilestoneEntity.fetchRequest()
        
        let calendar = Calendar.current
        let today = Date()

        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)),
              let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else {
            throw AnalyticsRepositoryErrors.dateError
        }

        let workspacePredicate = NSPredicate(format: "goal.workspace.id == %@", workspace.id.uuidString)
        let completionStatusPredicate = NSPredicate(format: "isCompleted == %@", NSNumber(value: true))
        
        let dateRangePredicate = NSPredicate(
            format: "completedAt >= %@ AND completedAt <= %@",
            startOfWeek as NSDate,
            endOfWeek as NSDate
        )
        
        request.predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [
                workspacePredicate,
                completionStatusPredicate,
                dateRangePredicate
            ]
        )

        return try CDStack.viewContext.fetch(request).map { MilestoneMapper.toDomain($0) }
    }
    
    func averageMilestoneCompletionTime(in workspace: Workspace) throws -> TimeInterval {
        let request: NSFetchRequest<MilestoneEntity> = MilestoneEntity.fetchRequest()
        
        let workspacePredicate = NSPredicate(format: "goal.workspace.id == %@", workspace.id.uuidString)
        let completionStatusPredicate = NSPredicate(format: "isCompleted == %@", NSNumber(value: true))
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            workspacePredicate,
            completionStatusPredicate
        ])
        
        let milestones = try CDStack.viewContext.fetch(request)
        
        let totalCompletionTime = milestones.compactMap { milestone -> TimeInterval? in
            guard let createdAt = milestone.createdAt, let completedAt = milestone.completedAt else { return nil }
            return completedAt.timeIntervalSince(createdAt)
        }.reduce(0, +)
    
        return milestones.isEmpty ? 0 : totalCompletionTime / Double(milestones.count)
    }
}
