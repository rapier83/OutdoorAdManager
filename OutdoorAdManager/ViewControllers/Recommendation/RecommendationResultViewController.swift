//
//  RecommendationResultViewController.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/19/25.
//
import Foundation
import UIKit
import CoreData

class RecommendationResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var recommendations: [Recommendation] = []
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "추천 결과"
        view.backgroundColor = Color.background
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RecommendationCell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendationCell", for: indexPath)
        let recommendation = recommendations[indexPath.row]
        
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let card = BaseCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = recommendation.title
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = Color.textPrimary
        
        let score = String(format: "%.2f", recommendation.score)
        let detailLabel = UILabel()
        detailLabel.text = "추천 점수: \(score)"
        detailLabel.font = .systemFont(ofSize: 13)
        detailLabel.textColor = Color.textSecondary
        
        let impressionLabel = UILabel()
        impressionLabel.text = "📣 예상 노출: \(Int.random(in: 1000...5000))명"
        impressionLabel.font = .systemFont(ofSize: 13)
        impressionLabel.textColor = Color.textSecondary
        
        let vStack = UIStackView(arrangedSubviews: [titleLabel, detailLabel, impressionLabel])
        vStack.axis = .vertical
        vStack.spacing = 4
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        card.addSubview(vStack)
        cell.contentView.addSubview(card)
        
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
            card.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            card.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
            card.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8),
            
            vStack.topAnchor.constraint(equalTo: card.topAnchor, constant: 12),
            vStack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 12),
            vStack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -12),
            vStack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -12)
        ])
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let recommendation = recommendations[indexPath.row]
        
        let alert = UIAlertController(
            title: "추천 반영",
            message: "'\(recommendation.title)' 캠페인으로 등록하시겠습니까?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "예", style: .default, handler: { _ in
            self.applyRecommendationAsCampaign(recommendation)
            ToastView(message: "✅ 캠페인에 반영되었습니다.").show(in: self.view)
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(alert, animated: true)
    }
    
    private func applyRecommendationAsCampaign(_ recommendation: Recommendation) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let campaign = AdCampaign(context: context)
        campaign.id = UUID()
        campaign.title = recommendation.title
        campaign.client = "자동 추천"
        campaign.brand = "AI 브랜드"
        campaign.budget = Double.random(in: 20000...60000)
        campaign.startDate = Date()
        campaign.endDate = Calendar.current.date(byAdding: .day, value: 30, to: Date())
        campaign.onAirDays = 30
        campaign.descriptionText = "추천 시스템을 통해 자동 생성된 캠페인입니다."
        campaign.uploadDate = Date()
        
        // 캠페인에 플레이스먼트 자동 연결
        let screenRequest: NSFetchRequest<MediaScreen> = MediaScreen.fetchRequest()
        if let screens = try? context.fetch(screenRequest).shuffled().prefix(2) {
            for screen in screens {
                let placement = CampaignPlacement(context: context)
                placement.id = UUID()
                placement.predictedImpression = Int16(Int.random(in: 1000...5000))
                placement.timeSlot = "08:00 ~ 20:00"
                placement.estimatedCost = Double.random(in: 500...1500)
                placement.location = screen.name ?? "Unknown"
                placement.campaign = campaign
                placement.screen = screen
            }
        }
        
        try? context.save()
    }
}
