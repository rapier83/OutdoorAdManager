//
//  DashBoardViewController.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/18/25 with All-Mighty System.
//
import UIKit

class DashboardViewController: UIViewController {

    private let stack = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CORA 대시보드"
        view.backgroundColor = Color.background
        setupButtons()
    }

    private func setupButtons() {
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])

        let features: [(String, UIViewController)] = [
            ("\u{1F4CD} 미디어 사이트", MediaSiteListViewController()),
            ("\u{1F6F0}\u{FE0F} 추천 결과", RecommendationResultViewController()),
            ("\u{1F4DD} 로그 보기", LogsViewController()),
            ("\u{1F4E6} 캠페인 도구", AdCampaignToolViewController())
        ]

        for (title, viewController) in features {
            let button = PrimaryButton()
            button.setTitle(title, for: .normal)
            button.addAction(UIAction(handler: { _ in
                self.navigationController?.pushViewController(viewController, animated: true)
            }), for: .touchUpInside)
            stack.addArrangedSubview(button)
        }
    }
}
