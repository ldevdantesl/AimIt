//
//  HomeAddWorkspaceView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 13.12.2024.
//

import SwiftUI

struct HomeAddWorkspaceView: View {
    @EnvironmentObject var workspaceVM: WorkspaceViewModel
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var titleErrorMsg: String?
    
    var body: some View {
        VStack{
            AIInfoField(
                title: "New Workspace",
                info: "Workspace: \(title)"
            )
            
            AITextField(
                titleName: "",
                placeholder: "Studies",
                text: $title,
                errorMsg: $titleErrorMsg
            )
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 20)
        .background(Color.aiBackground)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                AIButton(title: "Create") {
                    workspaceVM.addWorkspace(title: title)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    HomeAddWorkspaceView()
        .environmentObject(DIContainer().makeWorkspaceViewModel())
}
