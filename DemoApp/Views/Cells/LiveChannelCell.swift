//
//  LiveChannelCell.swift
//  DemoApp
//
//  Created by Dmytro Vakulinskyi on 19.11.2024.
//

import UIKit

class LiveChannelCell: UICollectionViewCell {
    static let identifier = "LiveChannelCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 52
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .systemGray5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let lockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lock_big")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(lockImageView)
        
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 104),
            imageView.heightAnchor.constraint(equalToConstant: 104),

            lockImageView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 5),
            lockImageView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 5),
            lockImageView.widthAnchor.constraint(equalToConstant: 32),
            lockImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    func configure(with asset: Asset) {
        imageView.loadImage(from: asset.image)
        lockImageView.isHidden = asset.purchased
    }
}
