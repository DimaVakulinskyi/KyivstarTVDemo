//
//  APIClient.swift
//  DemoApp
//
//  Created by Dmytro Vakulinskyi on 18.11.2024.
//

import Foundation
import Combine

final class APIClient {
    private let baseUrl = "https://api.json-generator.com/templates"
    private let token = "b3kgsqs1kqytlpact6fhh6pd8grvdj7kqm0nkvd1"

    private func makeRequest(for endpoint: String) -> URLRequest {
        var request = URLRequest(url: URL(string: "\(baseUrl)\(endpoint)")!)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }

    func fetchPromotions() -> AnyPublisher<PromotionsResponse, Error> {
        let request = makeRequest(for: "/j_BRMrbcY-5W/data")
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: PromotionsResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchCategories() -> AnyPublisher<CategoriesResponse, Error> {
        let request = makeRequest(for: "/eO-fawoGqaNB/data")
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: CategoriesResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchContentGroups() -> AnyPublisher<[ContentGroup], Error> {
        let request = makeRequest(for: "/PGgg02gplft-/data")
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [ContentGroup].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
