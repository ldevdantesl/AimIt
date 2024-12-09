//
//  MilestoneRepositoryTests.swift
//  AimItTests
//
//  Created by Buzurg Rakhimzoda on 5.12.2024.
//

import XCTest
import CoreData
@testable import AimIt

final class MilestoneRepositoryTests: XCTestCase {
    
    private var mileRepo: MilestoneRepository!
    private var goalRepo: GoalRepository!
    private var CDStack: CoreDataStack!
    private var milestones: [Milestone]!

    override func setUp() {
        super.setUp()
        self.CDStack = PersistentContainerFactory.makeInMemoryCoreDataStack(modelName: "AimIt")
        self.mileRepo = MilestoneRepositoryImpl(CDstack: CDStack)
        self.goalRepo = GoalRepositoryImpl(CDstack: CDStack)
        milestones = []
    }
    
    override func tearDown() {
        self.CDStack = nil
        self.mileRepo = nil
        self.goalRepo = nil
        milestones = []
        super.tearDown()
    }
    
    func testFetchingMilestones() throws {
        XCTAssertNoThrow(try mileRepo.fetchAllMilestones())
        milestones = try mileRepo.fetchAllMilestones()
        XCTAssertEqual(milestones.count, 0)
    }
    
    func testFetchingMilestonesForGoal() throws {
        try goalRepo.addGoal(title: "New Goal", desc: "Wow", deadline: nil, milestones: [])
        let goal = try goalRepo.fetchGoals().first!
        try mileRepo.addMilestone(desc: "New milestone", systemImage: "", to: goal)
        XCTAssertTrue(milestones.isEmpty)
        milestones = try mileRepo.fetchMilestones(for: goal)
        XCTAssertFalse(milestones.isEmpty)
    }
    
    func testUpdatingMilestone() throws {
        try goalRepo.addGoal(title: "New Goal", desc: "Wow", deadline: nil, milestones: [])
        let goal = try goalRepo.fetchGoals().first!
        try mileRepo.addMilestone(desc: "New milestone", systemImage: "", to: goal)
        XCTAssertTrue(milestones.isEmpty)
        milestones = try mileRepo.fetchMilestones(for: goal)
        XCTAssertFalse(milestones.isEmpty)
        
        let updatedDesc = "Updated milestone"
        XCTAssertEqual(milestones[0].desc, "New milestone")
        try mileRepo.updateMilestone(milestones[0], desc: updatedDesc, systemImage: nil)
        milestones = try mileRepo.fetchMilestones(for: goal)
        XCTAssertEqual(milestones[0].desc, "Updated milestone")
    }
    
    func testDeletingMilestone() throws {
        try goalRepo.addGoal(title: "New Goal", desc: "Wow", deadline: nil, milestones: [])
        let goal = try goalRepo.fetchGoals().first!
        try mileRepo.addMilestone(desc: "New milestone", systemImage: "", to: goal)
        XCTAssertTrue(milestones.isEmpty)
        milestones = try mileRepo.fetchMilestones(for: goal)
        XCTAssertFalse(milestones.isEmpty)
        
        try mileRepo.deleteMilestone(milestones[0])
        milestones = try mileRepo.fetchMilestones(for: goal)
        XCTAssertTrue(milestones.isEmpty)
    }
    
    func testToggleMilestoneCompletion() throws {
        try goalRepo.addGoal(title: "New Goal", desc: "Wow", deadline: nil, milestones: [])
        let goal = try goalRepo.fetchGoals().first!
        try mileRepo.addMilestone(desc: "New milestone", systemImage: "", to: goal)
        XCTAssertTrue(milestones.isEmpty)
        milestones = try mileRepo.fetchMilestones(for: goal)
        XCTAssertFalse(milestones.isEmpty)
        
        try mileRepo.toggleMilestoneCompletion(milestones[0])
        milestones = try mileRepo.fetchMilestones(for: goal)
        XCTAssertTrue(milestones[0].isCompleted)
    }

}
