//
//  RoundedImageView.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/19/25.
//


import UIKit

class RoundedImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }

    private func setupStyle() {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = 12
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }
}