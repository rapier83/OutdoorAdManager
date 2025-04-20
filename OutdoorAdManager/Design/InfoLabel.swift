//
//  InfoLabel.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/19/25.
//


import UIKit

class InfoLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }

    private func setupStyle() {
        font = UIFont.systemFont(ofSize: 13)
        textColor = Color.textSecondary
        numberOfLines = 0
    }
}