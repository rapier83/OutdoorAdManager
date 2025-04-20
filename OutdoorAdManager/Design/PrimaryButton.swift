//
//  PrimaryButton.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/19/25.
//


import UIKit

class PrimaryButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }

    private func setupStyle() {
        setTitleColor(Color.primaryButtonText, for: .normal)
        backgroundColor = Color.primaryButtonBackground
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        layer.cornerRadius = 12
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}