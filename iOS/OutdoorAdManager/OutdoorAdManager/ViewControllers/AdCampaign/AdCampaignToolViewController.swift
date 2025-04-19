//
//  AdCampaignToolViewController.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/19/25.
//


//  AdCampaignToolViewController.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/20/25.

import UIKit

class AdCampaignToolViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "캠페인 도구"
        setupLayout()
    }

    private func setupLayout() {
        let label = UILabel()
        label.text = "여기는 캠페인 관련 도구를 위한 화면입니다."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }
}
