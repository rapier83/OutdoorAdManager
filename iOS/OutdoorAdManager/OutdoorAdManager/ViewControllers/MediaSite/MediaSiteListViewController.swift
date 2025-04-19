//
//  MediaSiteListViewController.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/16/25.
//
import UIKit
import CoreData

class MediaSiteListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let tableView = UITableView()
    private var mediaSites: [MediaSite] = []

    private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "미디어 사이트"
        view.backgroundColor = Color.background
        setupTableView()
        fetchMediaSites()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func fetchMediaSites() {
        let request: NSFetchRequest<MediaSite> = MediaSite.fetchRequest()
        if let result = try? context.fetch(request) {
            mediaSites = result
            tableView.reloadData()
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaSites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "MediaSiteCell")
        let site = mediaSites[indexPath.row]

        cell.textLabel?.text = site.name ?? "알 수 없음"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        cell.textLabel?.textColor = Color.textPrimary

        let density = Int(site.populationDensity)
        let weather = site.weatherForecast ?? "-"
        cell.detailTextLabel?.text = "👥 \(density)명  •  ☀️ \(weather)"
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.detailTextLabel?.textColor = Color.textSecondary

        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = Color.cardBackground

        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let site = mediaSites[indexPath.row]
        let vc = MediaScreenListViewController()
        vc.mediaSite = site
        navigationController?.pushViewController(vc, animated: true)
    }
}


