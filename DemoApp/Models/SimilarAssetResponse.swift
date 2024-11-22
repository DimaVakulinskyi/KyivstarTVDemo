//
//  SimilarAssetResponse.swift
//  DemoApp
//
//  Created by Dmytro Vakulinskyi on 22.11.2024.
//

import Foundation

struct SimilarAssetResponse: Codable {
    let similar: [SimilarAsset]
}

struct SimilarAsset: Identifiable, Codable {
    var id: String
    var name: String
    var image: String
    var purchased: Bool
}
