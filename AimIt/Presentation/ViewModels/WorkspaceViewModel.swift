//
//  WorkspaceViewModel.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import Foundation
import Combine

final class WorkspaceViewModel: ObservableObject {
    @Published var currentWorkspace: Workspace?
    
    @Published var workspaces: [Workspace] = []
    @Published var errorMsg: String?
    
    private let currentWorkspaceKey = ConstantKeys.currentWorkspaceKey
    
    private let storageManager: StorageManager
    
    private let addWorkspaceUseCase: AddWorkspaceUseCase
    private let fetchWorkspacesUseCase: FetchWorkspacesUseCase
    private let editWorkspaceUseCase: EditWorkspaceUseCase
    private let deleteWorkspaceUseCase: DeleteWorkspaceUseCase
    
    init(
        addWorkspaceUseCase: AddWorkspaceUseCase,
        fetchWorkspacesUseCase: FetchWorkspacesUseCase,
        editWorkspaceUseCase: EditWorkspaceUseCase,
        deleteWorkspaceUseCase: DeleteWorkspaceUseCase,
        storageManager: StorageManager = UserDefaultsStorageManager()
    ) {
        self.addWorkspaceUseCase = addWorkspaceUseCase
        self.fetchWorkspacesUseCase = fetchWorkspacesUseCase
        self.editWorkspaceUseCase = editWorkspaceUseCase
        self.deleteWorkspaceUseCase = deleteWorkspaceUseCase
        self.storageManager = storageManager
        fetchWorkspaces()
    }
    
    func getCurrentWorkspace() {
        currentWorkspace = storageManager.getValue(for: currentWorkspaceKey)
    }
    
    func setCurrentWorkspace(_ workspace: Workspace) {
        storageManager.setValue(workspace, for: currentWorkspaceKey)
    }
    
    func addWorkspace(title: String){
        do {
            currentWorkspace = try addWorkspaceUseCase.execute(title: title)
        } catch {
            errorMsg = "Error creating workspace: \(error.localizedDescription)"
            print(errorMsg ?? "")
        }
    }
    
    func fetchWorkspaces(){
        do {
            self.workspaces = try fetchWorkspacesUseCase.execute()
            getCurrentWorkspace()
        } catch {
            errorMsg = "Error fetching workspaces: \(error.localizedDescription)"
            print(errorMsg ?? "")
        }
    }
    
    func editWorkspace(_ workspace: Workspace, newTitle: String, newGoals: [Goal]) {
        do {
            try editWorkspaceUseCase.execute(workspace, newTitle: newTitle, newGoals: newGoals)
        } catch {
            errorMsg = "Error editing workspace: \(error.localizedDescription)"
            print(errorMsg ?? "")
        }
    }
    
    func deleteWorkspace(_ workspace: Workspace) {
        do {
            try deleteWorkspaceUseCase.execute(workspace)
        } catch {
            errorMsg = "Error deleting workspace: \(error.localizedDescription)"
            print(errorMsg ?? "")
        }
    }
}
