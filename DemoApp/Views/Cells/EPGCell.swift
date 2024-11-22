//
//  EPGCell.swift
//  DemoApp
//
//  Created by Dmytro Vakulinskyi on 19.11.2024.
//

import UIKit

class EPGCell: UICollectionViewCell {
    static let identifier = "EPGCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .systemGray5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let lockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lock")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let progressBarBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let progressBar: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.addSubview(progressBarBackground)
        progressBarBackground.addSubview(progressBar)
        contentView.addSubview(titleLabel)
        contentView.addSubview(lockImageView)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var progressBarWidthConstraint: NSLayoutConstraint?

    private func setupConstraints() {
        progressBarWidthConstraint = progressBar.widthAnchor.constraint(equalToConstant: 0)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 216),
            imageView.heightAnchor.constraint(equalToConstant: 120),

            lockImageView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            lockImageView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
            lockImageView.widthAnchor.constraint(equalToConstant: 24),
            lockImageView.heightAnchor.constraint(equalToConstant: 24),

            progressBarBackground.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            progressBarBackground.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            progressBarBackground.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            progressBarBackground.heightAnchor.constraint(equalToConstant: 4),

            progressBar.bottomAnchor.constraint(equalTo: progressBarBackground.bottomAnchor),
            progressBar.leadingAnchor.constraint(equalTo: progressBarBackground.leadingAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 4),
            progressBarWidthConstraint!,

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }

    func configure(with asset: Asset) {
        imageView.loadImage(from: asset.image)
        titleLabel.text = asset.name
        lockImageView.isHidden = asset.purchased

        let maxWidth = imageView.frame.width
        let progressWidth = maxWidth * CGFloat(asset.progress) / 100.0
        progressBarWidthConstraint?.constant = progressWidth
        layoutIfNeeded()
    }
}
