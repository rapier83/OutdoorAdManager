//
//  BaseCardView.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/19/25.
//


import UIKit

class BaseCardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }

    private func setupStyle() {
        backgroundColor = Color.cardBackground
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
    }
}