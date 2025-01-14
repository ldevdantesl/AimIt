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
    
    let workspaceName: String
    
    var body: some View {
        
        TextField(text: $searchText) {
            Text("Search in \(workspaceName)...")
                .foregroundStyle(.aiLabel)
        }
        .padding(.leading, isFocused ? 15 : 50)
        .padding(.trailing, 45)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .focused($isFocused)
        .background(Color.aiSecondary, in: .rect(cornerRadius: 30))
        .submitLabel(.done)
        .onSubmit(of: .text){
            isFocused = false
        }
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
        .overlay(alignment: .trailing) {
            if isFocused && !searchText.isEmpty {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .padding(.trailing, 10)
                    .foregroundStyle(Color.accentColor)
                    .onTapGesture {
                        DispatchQueue.main.async {
                            withAnimation {
                                self.searchText = ""
                            }
                        }
                    }
            }
        }
        .padding(.horizontal, 20)
        .animation(.bouncy, value: isFocused)
    }
}

#Preview {
    AISearchBar(searchText: .constant(""), workspaceName: "Sd")
}
