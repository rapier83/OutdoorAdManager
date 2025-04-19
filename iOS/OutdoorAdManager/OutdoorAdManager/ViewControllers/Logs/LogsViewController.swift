//
//  LogsViewController.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/19/25.
//


import UIKit

class LogsViewController: UIViewController, UITableViewDataSource {

    private let tableView = UITableView()
    private var logs: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "서버 로그"
        view.backgroundColor = Color.background
        setupTableView()
        fetchLogs()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LogCell")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func fetchLogs() {
        // 🚧 여기서는 임시 데이터 사용
        logs = [
            "[INFO] 서버 실행 완료",
            "[INFO] 추천 시스템 초기화됨",
            "[DEBUG] 캠페인 5개 로드됨",
            "[WARN] 네트워크 지연 발생",
            "[INFO] /recommend 호출됨"
        ]
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogCell", for: indexPath)
        cell.textLabel?.text = logs[indexPath.row]
        cell.textLabel?.font = .monospacedSystemFont(ofSize: 13, weight: .regular)
        cell.textLabel?.textColor = Color.textSecondary
        cell.backgroundColor = .clear
        return cell
    }
} 
