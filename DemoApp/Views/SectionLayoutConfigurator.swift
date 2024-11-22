//
//  SectionLayoutConfigurator.swift
//  DemoApp
//
//  Created by Dmytro Vakulinskyi on 22.11.2024.
//

import UIKit

struct SectionLayoutConfigurator {
    static func layout(for section: Section) -> NSCollectionLayoutSection? {
        switch section {
        case .promotions:
            return createPromotionsSection()
        case .categories:
            return createCategoriesSection()
        case .movieSeries:
            return createMovieSeriesSection()
        case .liveChannel:
            return createLiveChannelSection()
        case .epg:
            return createEPGSection()
        }
    }
    
    private static func createPromotionsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(180)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0)
        
        return section
    }
    
    private static func createCategoriesSection() -> NSCollectionLayoutSection {
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(30)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(104),
                heightDimension: .absolute(130)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .estimated(104),
                heightDimension: .absolute(130)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 24, bottom: 5, trailing: 24)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        
        return section
    }
    
    private static func createMovieSeriesSection() -> NSCollectionLayoutSection {
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(30)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(104),
                heightDimension: .absolute(220)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .estimated(104),
                heightDimension: .absolute(220)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 24, bottom: 5, trailing: 24)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        
        return section
    }
    
    private static func createLiveChannelSection() -> NSCollectionLayoutSection {
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(30)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(104),
                heightDimension: .absolute(104)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .estimated(104),
                heightDimension: .absolute(104)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 24, bottom: 5, trailing: 24)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 8

        return section
    }
    
    private static func createEPGSection() -> NSCollectionLayoutSection {
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(30)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(216),
            heightDimension: .absolute(168)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(216),
            heightDimension: .absolute(168)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 24, bottom: 5, trailing: 24)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10

        return section
    }
}
