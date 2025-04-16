//
//  MediaScreenCell.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/16/25.
//


import UIKit

class MediaScreenCell: UITableViewCell {

    private let nameLabel = UILabel()
    private let resolutionLabel = UILabel()
    private let brightnessLabel = UILabel()
    private let statusLabel = UILabel()
    private let timeSlotLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let labels = [nameLabel, resolutionLabel, brightnessLabel, statusLabel, timeSlotLabel]
        labels.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = UIFont.systemFont(ofSize: 14)
            contentView.addSubview($0)
        }

        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textColor = .label

        let stack = UIStackView(arrangedSubviews: labels)
        stack.axis = .vertical
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with screen: MediaScreen) {
        nameLabel.text = screen.name
        resolutionLabel.text = "해상도: \(screen.width)x\(screen.height)"
        brightnessLabel.text = "밝기: \(String(format: "%.2f", screen.brightnessLevel))"
        statusLabel.text = "상태: \(screen.status ?? "-")"
        timeSlotLabel.text = "시간대: \(screen.timeSlot ?? "-")"
    }
}