//
//  AISearchBar.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 7.12.2024.
//

import SwiftUI

struct AISearchBar: View {
    
    @Binding var searchText: String
    @FocusState var isFocused: Bool
    
    var body: some View {
        
        TextField(text: $searchText) {
            Text("Search your goal...")
                .foregroundStyle(.aiLabel)
        }
        .padding(.leading, isFocused ? 15 : 50)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .focused($isFocused)
        .background(Color.aiSecondary, in: .rect(cornerRadius: 30))
        .overlay(alignment: .leading) {
            if !isFocused{
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(.leading, 20)
                    .foregroundStyle(.aiLabel)
            }
        }
        .padding(.horizontal, 20)
        .animation(.bouncy, value: isFocused)
    }
}

#Preview {
    AISearchBar(searchText: .constant(""))
}
