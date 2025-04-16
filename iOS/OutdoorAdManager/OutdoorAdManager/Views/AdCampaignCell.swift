//
//  AdCampaignCell.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/16/25.
//


import UIKit

class AdCampaignCell: UITableViewCell {

    private let titleLabel = UILabel()
    private let clientLabel = UILabel()
    private let brandLabel = UILabel()
    private let budgetLabel = UILabel()
    private let dateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let labels = [titleLabel, clientLabel, brandLabel, budgetLabel, dateLabel]
        labels.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = UIFont.systemFont(ofSize: 14)
            contentView.addSubview($0)
        }

        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .label

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

    func configure(with campaign: AdCampaign) {
        titleLabel.text = "캠페인: \(campaign.title ?? "-")"
        clientLabel.text = "클라이언트: \(campaign.client ?? "-")"
        brandLabel.text = "브랜드: \(campaign.brand ?? "-")"
        budgetLabel.text = "예산: ₩\(Int(campaign.budget))"
        if let start = campaign.startDate, let end = campaign.endDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd"
            dateLabel.text = "기간: \(formatter.string(from: start)) ~ \(formatter.string(from: end))"
        } else {
            dateLabel.text = "기간: -"
        }
    }
}