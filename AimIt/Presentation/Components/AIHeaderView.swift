//
//  AIHeaderView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 4.12.2024.
//

import SwiftUI

struct AIHeaderView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ZStack(alignment: .topLeading){
                Image("back")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 230)
                    .opacity(0.8)
                
                VStack{
                    Text("Today")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .foregroundStyle(.white)
                    Text("Dec 4 2024")
                        .font(.system(.subheadline, design: .rounded, weight: .semibold))
                        .foregroundStyle(.white)
                }
                .padding(.leading, 24)
                .padding(.top, 40)
            }
            
            ScrollView(.horizontal){
                LazyHStack{
                    ForEach(1..<31, id: \.self) { i in
                        CardView(day: i.description, other: "Wed")
                    }
                }
                .frame(height: 100)
                .padding(.horizontal, 24)
            }
            .scrollIndicators(.hidden)
        }
    }
    
    @ViewBuilder
    func CardView(day: String, other: String) -> some View {
        VStack{
            Text(day)
                .font(.system(.title3, design: .rounded, weight: .bold))
                .foregroundStyle(.white)
            Text(other)
                .font(.system(.subheadline, design: .rounded, weight: .semibold))
                .foregroundStyle(.white)
        }
        .padding(10)
        .border(.secondary, width: 2)
        .contentShape(.rect(cornerRadius: 15))
        .background(.background.opacity(0.2), in: .rect(cornerRadius: 5))
    }
}

#Preview{
    MainView()
}
