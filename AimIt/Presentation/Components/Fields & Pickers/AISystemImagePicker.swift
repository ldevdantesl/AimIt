//
//  AISystemImagePicker.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import SwiftUI

struct AISystemImagePicker: View {
    @Binding var selectedImage: String
    
    @State private var selectedCategory: SystemImageCategory = .allCategories[0]
    
    private let columns: [GridItem] = Array(repeating: GridItem(.fixed(40), spacing: 15), count: 6)
    
    var body: some View {
        VStack{
            Image(systemName: selectedImage)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundStyle(.aiLabel)
                .padding(20)
                .background(Color.aiOrange, in:.circle)
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
            
            VStack(alignment: .leading){
                selectedCategoryPicker()
                
                LazyVGrid(columns: columns, spacing: 20){
                    ForEach(selectedCategory.symbols, id: \.self) { symbol in
                        Button(action: { selectedImage = symbol }) {
                            Image(systemName: symbol)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(selectedImage == symbol ? Color.aiLabel : Color.aiSecondary)
                                .padding(15)
                                .background(selectedImage == symbol ? Color.orange : Color.aiSecondary2, in: .circle)
                        }
                    }
                    .animation(.bouncy, value: selectedImage)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .frame(maxWidth: UIConstants.screenWidth - 20)
                .background(Color.aiSecondary, in: .rect(cornerRadius: 25))
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                
            }
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func selectedCategoryPicker() -> some View {
        Picker("", selection: $selectedCategory) {
            ForEach(SystemImageCategory.allCategories, id:\.self){ cat in
                Label(cat.name, systemImage: cat.titleImage)
                    .tag(cat)
            }
        }
    }
}

#Preview {
    AISystemImagePicker(selectedImage: .constant("folder"))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aiBackground)
}
