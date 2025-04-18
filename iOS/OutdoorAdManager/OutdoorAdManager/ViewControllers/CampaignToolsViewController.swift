//
//  CampaignToolsViewController.swift
//  OutdoorAdManager
//

import UIKit
import CoreData

class CampaignToolsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "캠페인 도구"
        view.backgroundColor = .systemBackground
        setupButtons()
    }

    private func setupButtons() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false

        let resetButton = makeButton(title: "🔄 샘플 데이터 초기화", action: #selector(resetData))
        let debugButton = makeButton(title: "🧠 디버깅 로그 출력", action: #selector(debugData))
        let statButton = makeButton(title: "📊 캠페인 통계 보기", action: #selector(showStatistics))

        stack.addArrangedSubview(resetButton)
        stack.addArrangedSubview(debugButton)
        stack.addArrangedSubview(statButton)

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    private func makeButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }

    @objc private func resetData() {
        SampleDataLoader.shared.resetAllData()
        SampleDataLoader.shared.loadAll()
        print("🔄 샘플 데이터가 초기화되었습니다.")
    }

    @objc private func debugData() {
        SampleDataLoader.shared.debugCampaignMapping()
    }

    @objc private func showStatistics() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<AdCampaign> = AdCampaign.fetchRequest()
        if let campaigns = try? context.fetch(request) {
            let total = campaigns.count
            let budget = campaigns.reduce(0) { $0 + $1.budget }
            let alert = UIAlertController(
                title: "📊 통계 요약",
                message: "총 캠페인 수: \(total)\n예산 총합: ₩\(Int(budget))",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
        }
    }
}
