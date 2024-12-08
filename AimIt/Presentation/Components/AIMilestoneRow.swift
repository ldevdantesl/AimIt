//
//  AIMilestoneAdditionField.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct AIMilestoneRow: View {
    let milestone: Milestone
    
    let onDelete: ((Milestone) -> ())
    let onTap: ((Milestone) -> ())
    
    init(
        milestone: Milestone,
        onDelete: @escaping ((Milestone) -> ()),
        onTap: @escaping ((Milestone) -> ()) = {_ in}
    ) {
        self.onDelete = onDelete
        self.onTap = onTap
        self.milestone = milestone
    }
    
    var body: some View {
        HStack{
            Button(action: { onTap(milestone) }){
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.accentColor)
                    .frame(width: 50, height: 50)
                    .overlay {
                        Image(systemName: milestone.systemImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .foregroundStyle(.aiLabel)
                    }
                
                Text(milestone.desc)
                    .font(.system(.subheadline, design: .rounded, weight: .semibold))
                    .foregroundStyle(.aiLabel)
                    .padding(.leading, 10)
                    .frame(maxWidth: UIConstants.screenWidth, alignment: .leading)
                    .frame(height: 50)
                    .lineLimit(1)
                    .background(Color.aiSecondary, in: .rect(cornerRadius: 30))
            }
            
            Button(action: {onDelete(milestone)}) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.red)
                    .frame(width: 50, height: 50)
                    .overlay {
                        Image(systemName: "trash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .foregroundStyle(.aiLabel)
                    }
            }
        }
    }
}

#Preview {
    AIMilestoneRow(milestone: .sample, onDelete: {_ in})
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
