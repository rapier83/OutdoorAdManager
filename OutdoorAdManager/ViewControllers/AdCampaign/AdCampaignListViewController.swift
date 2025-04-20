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
        view.backgroundColor = Color.background
        setupTableView()
        fetchCampaigns()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AdCampaignCell")
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
        return campaigns.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdCampaignCell", for: indexPath)
        let campaign = campaigns[indexPath.row]

        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        let card = BaseCardView()
        card.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = campaign.title
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = Color.textPrimary

        let brand = campaign.brand ?? "-"
        let budget = String(format: "₩%.0f", campaign.budget)
        let detailLabel = UILabel()
        detailLabel.text = "브랜드: \(brand)   예산: \(budget)"
        detailLabel.font = .systemFont(ofSize: 13)
        detailLabel.textColor = Color.textSecondary

        let vStack = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let campaign = campaigns[indexPath.row]
        let detailVC = AdCampaignDetailViewController()
        detailVC.campaign = campaign
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

