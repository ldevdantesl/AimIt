//
//  AITimelineView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import Foundation
import SwiftUI

struct AITimelineView: View {
    var body: some View {
        VStack(spacing: 10){
            HStack{
                Text("Your Timeline")
                    .font(.system(.title3, design: .rounded, weight: .bold))
                    .foregroundStyle(.aiLabel)
                
                Spacer()
                
                HStack{
                    Text("June")
                        .font(.system(.subheadline, design: .rounded, weight: .light))
                    
                    Image(systemName: "chevron.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 10)
                }
                .foregroundStyle(.aiLabel)
            }
            .padding(.horizontal, 20)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10){
                    ForEach(0..<5, id: \.self) { _ in
                        AIDateCapsule(date: .now)
                    }
                }
                .padding(.horizontal, 20)
            }
            .frame(height: 80)
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    AITimelineView()
}
    
