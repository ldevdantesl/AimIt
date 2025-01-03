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
    
    @Published var workspaces: [Workspace] = []
    @Published var errorMsg: String?
    
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
        self.currentWorkspace = storageManager.getValue(for: currentWorkspaceKey) ?? Workspace(id: UUID(), title: "Goals", goals: [])
        self.prioritizeGoalUseCase = prioritizeGoalUseCase
        self.unprioritizeGoalUseCase = unprioritizeGoalUseCase
        fetchWorkspaces()
    }
    
    private func updateCurrentWorkspace() {
        storageManager.setValue(currentWorkspace, for: currentWorkspaceKey)
    }
    
    func addWorkspace(title: String){
        do {
            currentWorkspace = try addWorkspaceUseCase.execute(title: title)
            fetchWorkspaces()
        } catch {
            errorMsg = "Error creating workspace: \(error.localizedDescription)"
            print(errorMsg ?? "")
        }
    }
    
    func fetchWorkspaces(){
        do {
            self.workspaces = try fetchWorkspacesUseCase.execute()
        } catch {
            errorMsg = "Error fetching workspaces: \(error.localizedDescription)"
            print(errorMsg ?? "")
        }
    }
    
    func fetchCurrentWorkspace() {
        do {
            currentWorkspace = try fetchCurrentWorkspaceUseCase.execute(by: currentWorkspace.id)
            fetchWorkspaces()
        } catch {
            errorMsg = "Error fetching current workspace: \(error.localizedDescription)"
            print(errorMsg ?? "")
        }
    }
    
    func editWorkspace(_ workspace: Workspace, newTitle: String, newGoals: [Goal]) {
        do {
            try editWorkspaceUseCase.execute(workspace, newTitle: newTitle, newGoals: newGoals)
            fetchCurrentWorkspace()
        } catch {
            errorMsg = "Error editing workspace: \(error.localizedDescription)"
            print(errorMsg ?? "")
        }
    }
    
    func deleteWorkspace(_ workspace: Workspace) {
        do {
            try deleteWorkspaceUseCase.execute(workspace)
            fetchCurrentWorkspace()
        } catch {
            errorMsg = "Error deleting workspace: \(error.localizedDescription)"
            print(errorMsg ?? "")
        }
    }
    
    func prioritizeGoal(_ workspace: Workspace, goal: Goal) {
        do {
            try prioritizeGoalUseCase.execute(in: workspace, goal: goal)
            fetchCurrentWorkspace()
        } catch {
            errorMsg = "Error prioritizing goal: \(error.localizedDescription)"
            print(errorMsg ?? "")
        }
    }
    
    func unprioritizeGoal(in workspace: Workspace) {
        do {
            try unprioritizeGoalUseCase.execute(in: workspace)
            fetchCurrentWorkspace()
        } catch {
            errorMsg = "Error unprioritizing goal: \(error.localizedDescription)"
            print(errorMsg ?? "")
        }
    }
    
    func reprioritizeGoal(in workspace: Workspace, newGoal: Goal) {
        unprioritizeGoal(in: workspace)
        prioritizeGoal(workspace, goal: newGoal)
        fetchCurrentWorkspace()
    }
}
