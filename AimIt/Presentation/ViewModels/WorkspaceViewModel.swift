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
    
    init(
        addWorkspaceUseCase: AddWorkspaceUseCase,
        fetchWorkspacesUseCase: FetchWorkspacesUseCase,
        fetchCurrentWorkspaceUseCase: FetchCurrentWorkspaceUseCase,
        editWorkspaceUseCase: EditWorkspaceUseCase,
        deleteWorkspaceUseCase: DeleteWorkspaceUseCase,
        storageManager: StorageManager = UserDefaultsStorageManager()
    ) {
        self.addWorkspaceUseCase = addWorkspaceUseCase
        self.fetchWorkspacesUseCase = fetchWorkspacesUseCase
        self.fetchCurrentWorkspaceUseCase = fetchCurrentWorkspaceUseCase
        self.editWorkspaceUseCase = editWorkspaceUseCase
        self.deleteWorkspaceUseCase = deleteWorkspaceUseCase
        self.storageManager = storageManager
        self.currentWorkspace = storageManager.getValue(for: currentWorkspaceKey) ?? Workspace(id: UUID(), title: "Goals", goals: [])
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
            fetchWorkspaces()
        } catch {
            errorMsg = "Error editing workspace: \(error.localizedDescription)"
            print(errorMsg ?? "")
        }
    }
    
    func deleteWorkspace(_ workspace: Workspace) {
        do {
            try deleteWorkspaceUseCase.execute(workspace)
            fetchWorkspaces()
        } catch {
            errorMsg = "Error deleting workspace: \(error.localizedDescription)"
            print(errorMsg ?? "")
        }
    }
}
