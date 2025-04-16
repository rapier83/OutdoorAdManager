//
//  AdCampaignDetailViewController.swift
//  OutdoorAdManager
//
//  Created by ChatGPT on 4/16/25.
//

import UIKit

class AdCampaignDetailViewController: UIViewController {

    var campaign: AdCampaign?

    private let titleLabel = UILabel()
    private let clientLabel = UILabel()
    private let brandLabel = UILabel()
    private let budgetLabel = UILabel()
    private let dateLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("✅ 디테일 뷰가 로드됨")
        view.backgroundColor = .white
        title = campaign?.title ?? "캠페인 상세"
        setupLabels()
        configure()
    }

    private func setupLabels() {
        let labels = [titleLabel, clientLabel, brandLabel, budgetLabel, dateLabel]
        labels.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.numberOfLines = 0
            $0.font = UIFont.systemFont(ofSize: 16)
        }

        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)

        let stack = UIStackView(arrangedSubviews: labels)
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func configure() {
        guard let campaign = campaign else {
            print("❌ campaign is nil")
            return
        }
        
        titleLabel.text = "타이틀: \(campaign.title ?? "-")"
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
