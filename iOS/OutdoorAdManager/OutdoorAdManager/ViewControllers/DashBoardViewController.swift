//
//  DashBoardViewController.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/18/25.
//


//
//  DashBoardViewController.swift
//  OutdoorAdManager
//

import UIKit

class DashBoardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "대시보드"
        view.backgroundColor = .systemGroupedBackground
        setupDashboard()
    }

    private func setupDashboard() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        // Title
        let titleLabel = UILabel()
        titleLabel.text = "Outdoor Ad Manager"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)

        // Stats (예시용)
        let statLabel = UILabel()
        statLabel.text = "오늘 등록된 사이트: 10개"
        statLabel.font = UIFont.systemFont(ofSize: 16)
        statLabel.textColor = .secondaryLabel

        // 버튼: 사이트 목록
        let siteButton = UIButton(type: .system)
        siteButton.setTitle("📍 사이트 목록 보기", for: .normal)
        siteButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        siteButton.addTarget(self, action: #selector(openSiteList), for: .touchUpInside)

        // 버튼: 캠페인 도구
        let toolsButton = UIButton(type: .system)
        toolsButton.setTitle("🛠 캠페인 도구 열기", for: .normal)
        toolsButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        toolsButton.addTarget(self, action: #selector(openCampaignTools), for: .touchUpInside)

        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(statLabel)
        stack.addArrangedSubview(siteButton)
        stack.addArrangedSubview(toolsButton)

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    @objc private func openSiteList() {
        let siteListVC = MediaSiteListTableViewController()
        navigationController?.pushViewController(siteListVC, animated: true)
    }

    @objc private func openCampaignTools() {
        let toolsVC = CampaignToolsViewController()
        let nav = UINavigationController(rootViewController: toolsVC)
        present(nav, animated: true)
    }
}