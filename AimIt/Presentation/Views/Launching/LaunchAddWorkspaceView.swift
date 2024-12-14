//
//  AddWorkspaceView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import SwiftUI

struct LaunchAddWorkspaceView: View {
    @EnvironmentObject var workspaceVM: WorkspaceViewModel
    
    var onFinish: (() -> ())
    
    @State private var title: String = ""
    
    var body: some View {
        ScrollView {
            AIHeaderView(
                title: "Add Your First",
                subtitle: "Workspace"
            )
            
            Spacer(minLength: 25)
            
            AITextField(titleName: "Title", placeholder: "Sport", text: $title)
        }
        .background(Color.aiBackground)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                AIButton(title: "Create") {
                    workspaceVM.addWorkspace(title: title)
                    onFinish()
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        LaunchAddWorkspaceView(onFinish: {})
            .environmentObject(DIContainer().makeWorkspaceViewModel())
    }
}
