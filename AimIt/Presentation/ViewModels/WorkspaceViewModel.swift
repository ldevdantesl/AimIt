//
//  WorkspaceViewModel.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import Foundation
import Combine

final class WorkspaceViewModel: ObservableObject {
    @Published var currentWorkspace: Workspace {
        didSet { updateCurrentWorkspace(); fetchWorkspaces() }
    }
    
    @Published var workspaceForAnalytics: Workspace
    
    @Published var workspaces: [Workspace] = []
    @Published var errorMsg: String?
    
    @Published var sortSystem: (GoalEntity, GoalEntity) -> Bool = { $0.deadline < $1.deadline }{
        didSet {
            fetchCurrentWorkspace()
        }
    }
    
    private let currentWorkspaceKey = ConstantKeys.currentWorkspaceKey
    
    private let storageManager: StorageManager
    
    private let addWorkspaceUseCase: AddWorkspaceUseCase
    private let fetchWorkspacesUseCase: FetchWorkspacesUseCase
    private let fetchCurrentWorkspaceUseCase: FetchCurrentWorkspaceUseCase
    private let editWorkspaceUseCase: EditWorkspaceUseCase
    private let deleteWorkspaceUseCase: DeleteWorkspaceUseCase
    private let prioritizeGoalUseCase: PrioritizeGoalUseCase
    private let unprioritizeGoalUseCase: UnprioritizeGoalUseCase
    
    init(
        addWorkspaceUseCase: AddWorkspaceUseCase,
        fetchWorkspacesUseCase: FetchWorkspacesUseCase,
        fetchCurrentWorkspaceUseCase: FetchCurrentWorkspaceUseCase,
        editWorkspaceUseCase: EditWorkspaceUseCase,
        deleteWorkspaceUseCase: DeleteWorkspaceUseCase,
        prioritizeGoalUseCase: PrioritizeGoalUseCase,
        unprioritizeGoalUseCase: UnprioritizeGoalUseCase,
        storageManager: StorageManager = UserDefaultsStorageManager()
    ) {
        self.addWorkspaceUseCase = addWorkspaceUseCase
        self.fetchWorkspacesUseCase = fetchWorkspacesUseCase
        self.fetchCurrentWorkspaceUseCase = fetchCurrentWorkspaceUseCase
        self.editWorkspaceUseCase = editWorkspaceUseCase
        self.deleteWorkspaceUseCase = deleteWorkspaceUseCase
        self.storageManager = storageManager
        self.currentWorkspace = storageManager.getValue(for: currentWorkspaceKey) ?? Workspace.sample
        self.prioritizeGoalUseCase = prioritizeGoalUseCase
        self.unprioritizeGoalUseCase = unprioritizeGoalUseCase
        self.workspaceForAnalytics = storageManager.getValue(for: currentWorkspaceKey) ?? Workspace.sample
        fetchWorkspaces()
    }
    
    func addWorkspace(title: String){
        handleUseCase {
            currentWorkspace = try addWorkspaceUseCase.execute(title: title)
            fetchWorkspaces()
        }
    }
    
    func fetchWorkspaces(){
        handleUseCase {
            self.workspaces = try fetchWorkspacesUseCase.execute()
        }
    }
    
    func fetchCurrentWorkspace() {
        handleUseCase {
            currentWorkspace = try fetchCurrentWorkspaceUseCase.execute(by: currentWorkspace.id, sortSystem: sortSystem)
            fetchWorkspaces()
        }
    }
    
    func editWorkspace(_ workspace: Workspace, newTitle: String, newGoals: [Goal]) {
        handleUseCase {
            try editWorkspaceUseCase.execute(workspace, newTitle: newTitle, newGoals: newGoals)
            fetchCurrentWorkspace()
        }
    }
    
    func deleteWorkspace(_ workspace: Workspace) {
        handleUseCase {
            try deleteWorkspaceUseCase.execute(workspace)
            fetchCurrentWorkspace()
        }
    }
    
    func prioritizeGoal(_ workspace: Workspace, goal: Goal) {
        handleUseCase {
            try prioritizeGoalUseCase.execute(in: workspace, goal: goal)
            fetchCurrentWorkspace()
        }
    }
    
    func unprioritizeGoal(in workspace: Workspace) {
        handleUseCase {
            try unprioritizeGoalUseCase.execute(in: workspace)
            fetchCurrentWorkspace()
        }
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func handleUseCase(action: () throws -> ()) {
        do {
            try action()
        } catch  {
            self.errorMsg = "Error occuered: \(error.localizedDescription)"
            print(errorMsg ?? "")
        }
    }
    
    private func handleUseCase<T>(defaultValue: T, action: () throws -> T) -> T {
        do {
            return try action()
        } catch  {
            self.errorMsg = "Error occured: \(error.localizedDescription)"
            print(errorMsg ?? "")
            return defaultValue
        }
    }
    
    private func updateCurrentWorkspace() {
        storageManager.setValue(currentWorkspace, for: currentWorkspaceKey)
    }
}
