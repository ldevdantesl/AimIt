//
//  AddWorkspaceView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import SwiftUI

struct LaunchAddWorkspaceView: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var workspaceVM: WorkspaceViewModel
    
    var onFinish: (() -> ())
    
    @State private var title: String = ""
    @State private var titleErrorMsg: String? = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AIHeaderView(
                    title: "Add Your First",
                    subtitle: "Workspace"
                )
                
                Text("- Workspaces are used to organize goals into specific focus areas")
                    .font(.system(.caption, design: .rounded, weight: .light))
                    .foregroundStyle(.aiSecondary2)
                    .padding(.horizontal, 20)
                    .lineLimit(2)
            }
            
            Spacer(minLength: 25)
            
            AITextField(
                titleName: "Title",
                placeholder: "Sport",
                text: $title,
                errorMsg: $titleErrorMsg
            )
        }
        .background(Color.aiBackground)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                AIButton(
                    title: "Create",
                    color: titleErrorMsg != nil ? .secondary : userVM.themeColor,
                    action: addWorkspace
                )
                .disabled(titleErrorMsg != nil)
            }
        }
    }
    
    private func addWorkspace() {
        if titleErrorMsg == nil {
            workspaceVM.addWorkspace(title: title)
            onFinish()
        }
    }
}

#Preview {
    NavigationStack{
        LaunchAddWorkspaceView(onFinish: {})
            .environmentObject(DIContainer().makeWorkspaceViewModel())
    }
}
