//
//  CampaignPlacementListViewController.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/16/25.
//


import UIKit
import CoreData

class CampaignPlacementListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let tableView = UITableView()
    private var placements: [CampaignPlacement] = []

    private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "추천 결과"
        view.backgroundColor = .white
        setupTableView()
        fetchPlacements()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CampaignPlacementCell.self, forCellReuseIdentifier: "CampaignPlacementCell")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func fetchPlacements() {
        let fetchRequest: NSFetchRequest<CampaignPlacement> = CampaignPlacement.fetchRequest()
        do {
            placements = try context.fetch(fetchRequest)
            print("✅ 가져온 CampaignPlacement 수: \(placements.count)")
            tableView.reloadData()
        } catch {
            print("❌ CampaignPlacement fetch 실패: \(error)")
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CampaignPlacementCell", for: indexPath) as? CampaignPlacementCell else {
            return UITableViewCell()
        }
        let placement = placements[indexPath.row]
        cell.configure(with: placement)
        return cell
    }

    // MARK: - UITableViewDelegate (선택 시 Alert 예시)

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placement = placements[indexPath.row]
        let message = """
        캠페인: \(placement.campaign?.title ?? "-")
        위치: \(placement.screen?.name ?? "-")
        시간대: \(placement.timeSlot ?? "-")
        예상 노출 수: \(placement.predictedImpression)
        예상 비용: ₩\(Int(placement.estimatedCost))
        """
        let alert = UIAlertController(title: "배치 정보", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}