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
        view.backgroundColor = .white
        setupTableView()
        fetchMediaSites()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MediaSiteCell")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func fetchMediaSites() {
        let fetchRequest: NSFetchRequest<MediaSite> = MediaSite.fetchRequest()
        do {
            mediaSites = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            print("❌ Failed to fetch MediaSites: \(error)")
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaSites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaSiteCell", for: indexPath)
        let site = mediaSites[indexPath.row]
        let screenCount = (site.screens as? Set<MediaScreen>)?.count ?? 0
        print("📦 mediaSites count: \(mediaSites.count)")
        
        cell.textLabel?.text = "\(site.name ?? "(이름 없음)") (\(screenCount) 스크린)"
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let site = mediaSites[indexPath.row]
        let screenListVC = MediaScreenListViewController()
        screenListVC.mediaSite = site
        navigationController?.pushViewController(screenListVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
