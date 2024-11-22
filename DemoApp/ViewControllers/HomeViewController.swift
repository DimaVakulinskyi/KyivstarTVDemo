//
//  HomeViewController.swift
//  DemoApp
//
//  Created by Dmytro Vakulinskyi on 18.11.2024.
//

import UIKit
import Combine

class HomeViewController: UIViewController, UICollectionViewDelegate {
    private var collectionView: UICollectionView!
    private var viewModel = HomeViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: UICollectionViewDiffableDataSource<Section, ItemType>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureDataSource()
        bindViewModel()
        
        viewModel.fetchPromotions()
        viewModel.fetchCategories()
        viewModel.fetchContentGroups()
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBarLogo()
    }
    
    private func setupNavigationBarLogo() {
        let logoImage = UIImage(named: "logo_blue")
        
        let imageView = UIImageView(image: logoImage)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        navigationItem.titleView = imageView
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex) else { return nil }
            return SectionLayoutConfigurator.layout(for: section)
        }
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.identifier)
        collectionView.register(PromotionCell.self, forCellWithReuseIdentifier: PromotionCell.identifier)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.register(SeriesCell.self, forCellWithReuseIdentifier: SeriesCell.identifier)
        collectionView.register(LiveChannelCell.self, forCellWithReuseIdentifier: LiveChannelCell.identifier)
        collectionView.register(EPGCell.self, forCellWithReuseIdentifier: EPGCell.identifier)
        
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, ItemType>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item {
            case .promotion(let promotion):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionCell.identifier, for: indexPath) as! PromotionCell
                cell.configure(with: promotion)
                return cell
            case .category(let category):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
                cell.configure(with: category)
                return cell
            case .movieSeries(let asset):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesCell.identifier, for: indexPath) as! SeriesCell
                cell.configure(with: asset)
                return cell
            case .liveChannel(let asset):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LiveChannelCell.identifier, for: indexPath) as! LiveChannelCell
                cell.configure(with: asset)
                return cell
            case .epg(let asset):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EPGCell.identifier, for: indexPath) as! EPGCell
                cell.configure(with: asset)
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) -> UICollectionReusableView? in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            guard let section = Section(rawValue: indexPath.section), let headerTitle = section.headerTitle else {
                return nil
            }
            
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.identifier,
                for: indexPath
            ) as! SectionHeaderView
            
            header.configure(with: headerTitle, for: indexPath.section)
            header.delegate = self
            return header
        }
    }
    
    private func bindViewModel() {
        viewModel.$promotions
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applySnapshot()
            }
            .store(in: &cancellables)
        
        viewModel.$categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applySnapshot()
            }
            .store(in: &cancellables)
        
        viewModel.$contentGroups
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applySnapshot()
            }
            .store(in: &cancellables)
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ItemType>()
        
        if !viewModel.promotions.isEmpty {
            snapshot.appendSections([.promotions])
            snapshot.appendItems(viewModel.promotions.map { .promotion($0) }, toSection: .promotions)
        }
        
        if !viewModel.categories.isEmpty {
            snapshot.appendSections([.categories])
            snapshot.appendItems(viewModel.categories.map { .category($0) }, toSection: .categories)
        }
        
        let movieSeries = viewModel.movieSeriesAssets()
        if !movieSeries.isEmpty {
            snapshot.appendSections([.movieSeries])
            snapshot.appendItems(movieSeries.map { .movieSeries($0) }, toSection: .movieSeries)
        }
        
        let liveChannel = viewModel.liveChannelAssets()
        if !liveChannel.isEmpty {
            snapshot.appendSections([.liveChannel])
            snapshot.appendItems(movieSeries.map { .liveChannel($0) }, toSection: .liveChannel)
        }
        
        let epg = viewModel.epgAssets()
        if !epg.isEmpty {
            snapshot.appendSections([.epg])
            snapshot.appendItems(epg.map { .epg($0)}, toSection: .epg)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension HomeViewController: SectionHeaderViewDelegate {
    func didTapDeleteButton(in section: Int) {
        guard let sectionType = Section(rawValue: section) else { return }
        
        viewModel.clear(section: sectionType)
        applySnapshot()
    }
}
