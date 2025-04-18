//  AdCampaignListViewController.swift
//  OutdoorAdManager

import UIKit
import CoreData

class AdCampaignListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var mediaScreen: MediaScreen?
    private var campaigns: [AdCampaign] = []
    private let tableView = UITableView()

    private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = mediaScreen?.name ?? "캠페인 목록"
        view.backgroundColor = .white
        setupTableView()
        fetchCampaigns()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AdCampaignCell.self, forCellReuseIdentifier: "AdCampaignCell")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func fetchCampaigns() {
        guard let screen = mediaScreen else { return }
        guard let placements = screen.placements as? Set<CampaignPlacement> else { return }

        let uniqueCampaigns = Set(placements.compactMap { $0.campaign })
        campaigns = Array(uniqueCampaigns)
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if campaigns.isEmpty {
            let label = UILabel()
            label.text = "노출된 캠페인이 없습니다"
            label.textAlignment = .center
            label.textColor = .gray
            label.font = UIFont.systemFont(ofSize: 16)
            tableView.backgroundView = label
        } else {
            tableView.backgroundView = nil
        }
        return campaigns.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AdCampaignCell", for: indexPath) as? AdCampaignCell else {
            return UITableViewCell()
        }
        cell.configure(with: campaigns[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let campaign = campaigns[indexPath.row]
        let detailVC = AdCampaignDetailViewController()
        detailVC.campaign = campaign
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
