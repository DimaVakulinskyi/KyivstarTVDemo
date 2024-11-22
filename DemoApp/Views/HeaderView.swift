//
//  HeaderView.swift
//  DemoApp
//
//  Created by Dmytro Vakulinskyi on 21.11.2024.
//

import UIKit

protocol SectionHeaderViewDelegate: AnyObject {
    func didTapDeleteButton(in section: Int)
}

class SectionHeaderView: UICollectionReusableView {
    static let identifier = "SectionHeaderView"

    weak var delegate: SectionHeaderViewDelegate?
    private var sectionIndex: Int = 0

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Del", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(deleteButton)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        deleteButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with title: String, for section: Int) {
        titleLabel.text = title
        sectionIndex = section
    }

    @objc private func didTapDelete() {
        delegate?.didTapDeleteButton(in: sectionIndex)
    }
}
