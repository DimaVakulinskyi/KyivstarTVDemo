//
//  PromotionCell.swift
//  DemoApp
//
//  Created by Dmytro Vakulinskyi on 19.11.2024.
//

import UIKit

class PromotionCell: UICollectionViewCell {
    static let identifier = "PromotionCell"

    private var imageView = UIImageView()
    private var overlayView = UIView()
    private var pageControl = UIPageControl()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupImageView()
        setupOverlay()
        setupPageControl()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.cancelImageLoad()
    }
    
    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .systemGray5
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 328),
            imageView.heightAnchor.constraint(equalToConstant: 180),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    private func setupOverlay() {
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(overlayView)

        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            overlayView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupPageControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = UIColor.white
        overlayView.addSubview(pageControl)

        pageControl.setContentHuggingPriority(.required, for: .vertical)
        pageControl.setContentCompressionResistancePriority(.required, for: .vertical)

        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            pageControl.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor)
        ])
    }

    func configure(with promotion: Promotion) {
        if let url = URL(string: promotion.image) {
            imageView.loadImage(from: url)
        } else {
            imageView.image = UIImage(named: "defaultImage")
        }
    }

    func updatePageControl(currentPage: Int, totalPages: Int) {
        pageControl.numberOfPages = totalPages
        pageControl.currentPage = currentPage
    }
}
