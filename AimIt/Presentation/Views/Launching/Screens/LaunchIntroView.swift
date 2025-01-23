//
//  IntroView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import SwiftUI

struct LaunchIntroView: View {
    @EnvironmentObject var coordinator: LaunchCoordinator
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        NavigationStack(path: $coordinator.path){
            ScrollView{
                TabView(selection: $selectedTab) {
                    item(
                        imageName: "Intro1",
                        title: "Start Achieving your goals 🥳",
                        info: "Set the goal, think about the steps to achieve it and start working towards it.",
                        tag: 0
                    )
                    
                    item(
                        imageName: "Intro2",
                        title: "Set milestones and track progress",
                        info: "Don't hurry! ⚡️ \nSet milestones along the way to keep yourself motivated.",
                        tag: 1
                    )
                    
                    item(
                        imageName: "Intro3",
                        title: "Track goals in every device",
                        info: "Icloud syncronization ☁️\nTrack your progress and see goals in real time.",
                        tag: 2
                    )
                }
                .frame(maxWidth: .infinity)
                .frame(height: UIConstants.halfHeight + 100)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .background(Color.aiBackground)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    AIButton(title: "Continue") {
                        if selectedTab < 2 {
                            withAnimation {
                                selectedTab+=1
                            }
                        } else {
                            coordinator.push(to: .addWorkspace)
                        }
                        
                    }
                }
            }
            .navigationDestination(for: LaunchScreens.self) { screen in
                coordinator.build(screen: screen)
            }
        }
    }
    
    @ViewBuilder
    private func item(imageName: String, title: String, info: String, tag: Int) -> some View {
        VStack{
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 310)
                .padding(.bottom, 25)
            
            AIInfoField(
                title: title,
                info: info,
                infoFontStyle: .title3
            )
    
            HStack{
                ForEach(0..<3) { i in
                    Image(systemName: selectedTab == i ? "circle.fill" : "circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 10)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .tag(tag)
    }
}

#Preview {
    LaunchIntroView()
        .environmentObject(LaunchCoordinator(onFinish: {}))
}
