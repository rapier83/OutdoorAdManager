//
//  CampaignPlacementCell.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/16/25.
//


import UIKit

class CampaignPlacementCell: UITableViewCell {

    private let campaignTitleLabel = UILabel()
    private let screenNameLabel = UILabel()
    private let timeSlotLabel = UILabel()
    private let impressionLabel = UILabel()
    private let costLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let labels = [campaignTitleLabel, screenNameLabel, timeSlotLabel, impressionLabel, costLabel]
        labels.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = UIFont.systemFont(ofSize: 14)
            contentView.addSubview($0)
        }

        campaignTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        campaignTitleLabel.textColor = .label

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

    func configure(with placement: CampaignPlacement) {
        campaignTitleLabel.text = "캠페인: \(placement.campaign?.title ?? "-")"
        screenNameLabel.text = "스크린: \(placement.screen?.name ?? "-")"
        timeSlotLabel.text = "시간대: \(placement.timeSlot ?? "-")"
        impressionLabel.text = "예상 노출 수: \(placement.predictedImpression)"
        costLabel.text = "예상 비용: ₩\(Int(placement.estimatedCost))"
    }
}