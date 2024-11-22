//
//  HomeViewModel.swift
//  DemoApp
//
//  Created by Dmytro Vakulinskyi on 18.11.2024.
//

import Foundation
import Combine

class HomeViewModel {
    @Published var promotions: [Promotion] = []
    @Published var categories: [Category] = []
    @Published var contentGroups: [ContentGroup] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let apiClient = APIClient()
    
    func fetchPromotions() {
        apiClient.fetchPromotions()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching promotions: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.promotions = response.promotions
            })
            .store(in: &cancellables)
    }
    
    func fetchCategories() {
        apiClient.fetchCategories()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching categories: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.categories = response.categories
            })
            .store(in: &cancellables)
    }
    
    func fetchContentGroups() {
        apiClient.fetchContentGroups()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { [weak self] groups in
                groups.forEach { print($0) }
                self?.contentGroups = groups
            })
            .store(in: &cancellables)
    }
    
    func movieSeriesAssets() -> [Asset] {
        contentGroups.forEach { group in
        }
        
        let filteredGroups = contentGroups.filter { group in
            !group.hidden && group.type.contains(where: { $0.uppercased() == "MOVIE" || $0.uppercased() == "SERIES" })
        }
        
        let assets = filteredGroups.flatMap { $0.assets }
        return assets
    }
    
    func liveChannelAssets() -> [Asset] {
        let filteredGroups = contentGroups.filter { group in
            !group.hidden && group.type.contains(where: { $0.uppercased() == "LIVECHANNEL" })
        }
        
        let assets = filteredGroups.flatMap { $0.assets }
        return assets
    }
    
    func epgAssets() -> [Asset] {
        let filteredGroups = contentGroups.filter { group in
            !group.hidden && group.type.contains(where: { $0.uppercased() == "EPG" })
        }
        
        let assets = filteredGroups.flatMap { $0.assets }
        return assets
    }
    
    func clear(section: Section) {
        switch section {
        case .categories:
            categories.removeAll()
        case .movieSeries:
            contentGroups = contentGroups.filter { !$0.type.contains(where: { $0.uppercased() == "MOVIE" || $0.uppercased() == "SERIES" }) }
        case .liveChannel:
            contentGroups = contentGroups.filter { !$0.type.contains(where: { $0.uppercased() == "LIVECHANNEL" }) }
        case .epg:
            contentGroups = contentGroups.filter { !$0.type.contains(where: { $0.uppercased() == "EPG" }) }
        case .promotions:
            promotions.removeAll()
        }
    }
}
