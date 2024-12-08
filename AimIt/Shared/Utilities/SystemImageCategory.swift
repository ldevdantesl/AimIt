//
//  SystemImageCategory.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 8.12.2024.
//

import Foundation

struct SystemImageCategory: Codable, Hashable{
    let name: String
    let titleImage: String
    let symbols: [String]
}

extension SystemImageCategory {
    static let allCategories: [SystemImageCategory] = Bundle.main.decode("SystemImageCategory.json")
}
