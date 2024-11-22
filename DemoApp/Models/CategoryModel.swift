//
//  CategoryModel.swift
//  DemoApp
//
//  Created by Dmytro Vakulinskyi on 19.11.2024.
//

import Foundation

struct CategoriesResponse: Codable {
    let categories: [Category]
}

struct Category: Codable, Hashable, Sendable {
    let id: String
    let name: String
    let image: String
}
