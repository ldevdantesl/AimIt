//
//  IntroView.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 11.12.2024.
//

import SwiftUI

struct LaunchIntroView: View {
    @EnvironmentObject var userVM: UserViewModel
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
                        title: "Set milestones⚡️",
                        info: "Set milestones along the way to keep yourself motivated.",
                        tag: 1
                    )
                    
                    item(
                        imageName: "Intro3",
                        title: "Prioritize goals 📌",
                        info: "Accelerate your success by focusing on your top priority first.",
                        tag: 2
                    )
                    
                    item(
                        imageName: "Intro4",
                        title: "Make analysis 📊",
                        info: "Insightful Analysis for Strategic Decision-Making",
                        tag: 3
                    )
                }
                .frame(maxWidth: .infinity)
                .frame(height: UIConstants.halfHeight + 100)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .background(Color.aiBackground)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    AIButton(
                        title: selectedTab < 3 ? "Next" : "Continue",
                        color: userVM.themeColor,
                        action: nextIntro
                    )
                    .contentTransition(.numericText())
                }
            }
            .navigationDestination(for: LaunchScreens.self) { screen in
                coordinator.build(screen: screen)
            }
        }
    }
    
    private func nextIntro() {
        if selectedTab < 3 {
            withAnimation {
                selectedTab+=1
            }
        } else {
            coordinator.push(to: .addProfile)
        }
    }
    
    @ViewBuilder
    private func item(
        imageName: String,
        title: String,
        info: String,
        tag: Int
    ) -> some View {
        VStack{
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 310)
                .padding(.bottom, 25)
            
            HStack{
                AIInfoField(
                    title: title,
                    info: info,
                    infoFontStyle: .title3,
                    swappedPostions: true
                )
                
                VStack{
                    Spacer()
                    ForEach(0..<4) { i in
                        Image(systemName: selectedTab == i ? "circle.fill" : "circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10, height: 10)
                            .foregroundStyle(.aiBeige)
                    }
                    Spacer()
                }
                .frame(height: 50)
                .padding(.horizontal, 20)
            }
        }
        .tag(tag)
    }
}

#Preview {
    LaunchIntroView()
        .environmentObject(LaunchCoordinator(onFinish: {}))
        .environmentObject(DIContainer().makeUserViewModel())
}
