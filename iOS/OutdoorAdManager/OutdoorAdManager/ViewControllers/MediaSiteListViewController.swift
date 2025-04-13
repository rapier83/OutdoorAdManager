//
//  MediaSiteListViewController.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/11/25.
//

// 📄 MediaSiteListViewController.swift

import UIKit

class MediaSiteListViewController: UIViewController {

    private let tableView = UITableView()
    private var mediaSites: [MediaSite] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupTableView()
        setupSampleButton() // 👈 버튼 추가!
        fetchMediaSites()
    }

    private func setupStyle() {
        title = "미디어 사이트"
        view.backgroundColor = Color.background
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: Color.textPrimary
        ]
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorColor = Color.divider
        tableView.register(MediaSiteCell.self, forCellReuseIdentifier: "MediaSiteCell")
    }
    
    private func setupSampleButton() {
        let button = UIBarButtonItem(title: "샘플삽입", style: .plain, target: self, action: #selector(insertSampleData))
        navigationItem.rightBarButtonItem = button
    }

    @objc private func insertSampleData() {
        SampleDataLoader.loadAllSampleData()
        fetchMediaSites()
    }

    private func fetchMediaSites() {
        mediaSites = MediaSiteManager.shared.fetchAllSites()
        tableView.reloadData()
    }
}


extension MediaSiteListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mediaSites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let site = mediaSites[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaSiteCell", for: indexPath) as! MediaSiteCell
        cell.configure(with: site)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selected = mediaSites[indexPath.row]
        print("🔎 선택된 사이트: \(selected.buildingName ?? "")")
        // TODO: 다음 화면으로 Push
    }
}
