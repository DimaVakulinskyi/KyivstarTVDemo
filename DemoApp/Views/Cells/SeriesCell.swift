//
//  SeriesCell.swift
//  DemoApp
//
//  Created by Dmytro Vakulinskyi on 19.11.2024.
//

import UIKit

class SeriesCell: UICollectionViewCell {
    static let identifier = "SeriesCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .systemGray5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let lockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "lock")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let progressBarBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 2
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let progressBar: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 2
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var progressBarWidthConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(lockImageView)
        contentView.addSubview(titleLabel)
        imageView.addSubview(progressBarBackground)
        progressBarBackground.addSubview(progressBar)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        progressBarWidthConstraint = progressBar.widthAnchor.constraint(equalToConstant: 0)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 104),
            imageView.heightAnchor.constraint(equalToConstant: 156),

            lockImageView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            lockImageView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
            lockImageView.widthAnchor.constraint(equalToConstant: 20),
            lockImageView.heightAnchor.constraint(equalToConstant: 20),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),

            progressBarBackground.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            progressBarBackground.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            progressBarBackground.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            progressBarBackground.heightAnchor.constraint(equalToConstant: 4),

            progressBar.leadingAnchor.constraint(equalTo: progressBarBackground.leadingAnchor),
            progressBar.topAnchor.constraint(equalTo: progressBarBackground.topAnchor),
            progressBar.bottomAnchor.constraint(equalTo: progressBarBackground.bottomAnchor),
            progressBarWidthConstraint!
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
