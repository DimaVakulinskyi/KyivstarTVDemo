//
//  ContentGroupModel.swift
//  DemoApp
//
//  Created by Dmytro Vakulinskyi on 19.11.2024.
//

import Foundation

struct ContentGroup: Codable, Hashable, Sendable {
    let id: String
    let name: String
    let type: [String]
    let assets: [Asset]
    let hidden: Bool
    let sortIndex: Int
    let canBeDeleted: Bool
}

struct Asset: Codable, Hashable, Sendable {
    let id: String
    let name: String
    let image: URL
    let company: String
    let progress: Int
    let purchased: Bool
    let sortIndex: Int
}
