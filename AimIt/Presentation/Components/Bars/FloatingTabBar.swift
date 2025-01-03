//
//  FloatingTabBar.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 2.01.2025.
//

import SwiftUI

struct FloatingTabBar: View {
    @EnvironmentObject var tabCoordinator: TabCoordinator
    
    let action: (() -> Void)?
    
    init(action: (() -> Void)? = nil) {
        self.action = action
    }
    
    private let allTabs = CustomTab.allCases
    
    var body: some View {
        HStack {
            HStack{
                ForEach(allTabs, id: \.self) { tab in
                    if tab != tabCoordinator.selectedTab {
                        Button {
                            withAnimation(.bouncy) {
                                DispatchQueue.main.async {
                                    tabCoordinator.selectedTab = tab
                                }
                            }
                        } label: {
                            Image(systemName: tab.rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.aiSecondary2)
                                .padding(.leading, tab == .home ? 20 : 0)
                                .padding(.trailing, tab == .settings ? 20 : 0)
                        }
                    } else {
                        HStack {
                            Image(systemName: tab.rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.aiLabel)
                            
                            Text(tab.title)
                                .font(.system(.subheadline, design: .rounded, weight: .semibold))
                                .foregroundStyle(.aiLabel)
                                .lineLimit(1)
                        }
                        .padding(10)
                        .padding(.horizontal, 5)
                        .background(Color.accentColor)
                        .padding(.leading, tab == .home ? 10 : 0)
                        .padding(.trailing, tab == .settings ? 10 : 0)
                    }
                    if tab != .settings {
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 7)
            .background(Color.aiLabel, in: .capsule)
            
            Spacer(minLength: 15)
            
            Button(action: { action?() }){
                Image(systemName: tabCoordinator.selectedTab.specialButton)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.aiLabel)
                    .padding(19)
                    .background(Color.accentColor, in: .circle)
            }
        }
        .padding(.horizontal, 20)
        .shadow(color: .aiBlack.opacity(0.4), radius: 5, x: 0, y: 5)
    }
}

#Preview {
    FloatingTabBar(action: {})
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
        .environmentObject(TabCoordinator())
}
