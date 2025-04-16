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
        view.backgroundColor = .white
        setupTableView()
        fetchScreens()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MediaScreenCell.self, forCellReuseIdentifier: "MediaScreenCell")
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MediaScreenCell", for: indexPath) as? MediaScreenCell else {
            return UITableViewCell()
        }
        let screen = mediaScreens[indexPath.row]
        cell.configure(with: screen)
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let screen = mediaScreens[indexPath.row]
        let message = "밝기: \(screen.brightnessLevel)\n시간대: \(screen.timeSlot ?? "-")"
        let alert = UIAlertController(title: screen.name, message: message, preferredStyle: .alert)
        
        let campaignVC = AdCampaignListViewController()
        campaignVC.mediaScreen = screen
        navigationController?.pushViewController(campaignVC, animated: true)
    }
    

}
