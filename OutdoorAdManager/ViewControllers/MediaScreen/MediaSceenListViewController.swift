//
//  MediaSceenListViewController.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/16/25.
//
import UIKit
import CoreData

class MediaScreenListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var mediaSite: MediaSite?
    private let tableView = UITableView()
    private var mediaScreens: [MediaScreen] = []

    private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = mediaSite?.name ?? "스크린 목록"
        view.backgroundColor = Color.background
        setupTableView()
        fetchScreens()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MediaScreenCell")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func fetchScreens() {
        guard let site = mediaSite, let screens = site.screens as? Set<MediaScreen> else { return }
        mediaScreens = screens.sorted(by: { $0.name ?? "" < $1.name ?? "" })
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaScreens.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaScreenCell", for: indexPath)
        let screen = mediaScreens[indexPath.row]

        // 기존 셀 콘텐츠 제거
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        let card = BaseCardView()
        card.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = screen.name
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = Color.textPrimary

        let subLabel = UILabel()
        let brightness = String(format: "%.0f", screen.brightnessLevel * 100)
        let cost = String(format: "%.0f", screen.estimatedCost)
        subLabel.text = "☀️ 밝기: \(brightness)%  | 💸 비용: ₩\(cost)"
        subLabel.font = .systemFont(ofSize: 13)
        subLabel.textColor = Color.textSecondary

        let vStack = UIStackView(arrangedSubviews: [titleLabel, subLabel])
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
        let screen = mediaScreens[indexPath.row]

        let campaignVC = AdCampaignListViewController()
        campaignVC.mediaScreen = screen
        navigationController?.pushViewController(campaignVC, animated: true)
    }
}
