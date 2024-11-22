//
//  PromotionModel.swift
//  DemoApp
//
//  Created by Dmytro Vakulinskyi on 19.11.2024.
//

import Foundation

struct PromotionsResponse: Codable {
    let promotions: [Promotion]
}

struct Promotion: Codable, Hashable, Sendable {
    let id: String
    let name: String
    let image: String
    let company: String
    let updatedAt: String
    let releaseDate: String
}
