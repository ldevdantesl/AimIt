//
//  AimItTests.swift
//  AimItTests
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import XCTest
import CoreData
@testable import AimIt


final class GoalRepositoryTests: XCTestCase {
    
    private var CDStack: CoreDataStack!
    private var goalRepository: GoalRepository!
    private var goals: [Goal] = []

    override func setUp() {
        super.setUp()
        self.CDStack = PersistentContainerFactory.makeInMemoryCoreDataStack(modelName: "AimIt")
        self.goalRepository = GoalRepositoryImpl(CDstack: CDStack)
    }
    
    override func tearDown() {
        self.CDStack = nil
        self.goalRepository = nil
        goals = []
        super.tearDown()
    }
    
    func testFetching() throws {
        goals = try goalRepository.fetchGoals()
        XCTAssertEqual(goals.count, 0)
    }
    
    func testAdding() throws {
        try goalRepository.addGoal(title: "AddingGoal", desc: nil, deadline: .now, milestones: [])
        goals = try goalRepository.fetchGoals()
        XCTAssertEqual(goals.count, 1)
    }
    
    func testRemoving() throws {
        try goalRepository.addGoal(title: "RemovingGoal", desc: nil, deadline: .now, milestones: [])
        goals = try goalRepository.fetchGoals()
        try goalRepository.deleteGoal(goals[0])
        goals = try goalRepository.fetchGoals()
        XCTAssertEqual(goals.count, 0)
    }
    
    func testCompleting() throws {
        try goalRepository.addGoal(title: "CompletionGoal", desc: nil, deadline: .now, milestones: [])
        goals = try goalRepository.fetchGoals()
        XCTAssertFalse(goals[0].isCompleted)
        XCTAssertNil(goals[0].completedAt)
        try goalRepository.completeGoal(goals[0])
        goals = try goalRepository.fetchGoals()
        XCTAssertTrue(goals[0].isCompleted)
        XCTAssertNotNil(goals[0].completedAt)
    }
    
    func testUcompleting() throws {
        try goalRepository.addGoal(title: "CompletionGoal", desc: nil, deadline: .now, milestones: [])
        goals = try goalRepository.fetchGoals()
        XCTAssertFalse(goals[0].isCompleted)
        XCTAssertNil(goals[0].completedAt)
        try goalRepository.completeGoal(goals[0])
        goals = try goalRepository.fetchGoals()
        XCTAssertTrue(goals[0].isCompleted)
        XCTAssertNotNil(goals[0].completedAt)
        try goalRepository.uncompleteGoal(goals[0])
        goals = try goalRepository.fetchGoals()
        XCTAssertFalse(goals[0].isCompleted)
        XCTAssertNil(goals[0].completedAt)
    }
    
    func testUpdating() throws {
        let title = "Title"
        let desc = "Desc"
        let deadline = Date().addingTimeInterval(60)
        
        try goalRepository.addGoal(title: title, desc: desc, deadline: deadline, milestones: [])
        goals = try goalRepository.fetchGoals()
        
        XCTAssertEqual(goals[0].title, title)
        XCTAssertEqual(goals[0].desc, desc)
        XCTAssertEqual(goals[0].deadline, deadline)
        XCTAssertEqual(goals[0].milestones, [])
        
        let updatedTitle = "UpdatedTitle"
        let updatedDesc = "UpdatedDesc"
        let updatedDeadline = Date().addingTimeInterval(120)
        
        
        try goalRepository.editGoal(
            goals[0],
            newTitle: updatedTitle,
            newDesc: updatedDesc,
            newDeadline: updatedDeadline
        )
        
        goals = try goalRepository.fetchGoals()
        
        XCTAssertEqual(goals[0].title, updatedTitle)
        XCTAssertEqual(goals[0].desc, updatedDesc)
        XCTAssertEqual(goals[0].deadline, updatedDeadline)
    }
}
