//
//  SectionTitleView.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/19/25.
//


import UIKit

class SectionTitleView: UIView {
    let label = UILabel()

    init(title: String) {
        super.init(frame: .zero)
        label.text = title
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = Color.textPrimary
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}