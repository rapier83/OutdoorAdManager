//
//  MediaSiteManager.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/10/25.
//

// 📄 MediaSiteManager.swift

import UIKit

class PlacementResultViewController: UIViewController, UITableViewDataSource {

    private let tableView = UITableView()
    private let simulateButton = UIButton(type: .system)
    private var placements: [String] = [] // 간단한 텍스트 리스트

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("✅ ViewController loaded!")

        setupTableView()
        setupButton()
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: simulateButton.topAnchor, constant: -20),
            
            simulateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            simulateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            simulateButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }

    private func setupButton() {
        simulateButton.setTitle("시뮬레이션 실행", for: .normal)
        simulateButton.translatesAutoresizingMaskIntoConstraints = false
        simulateButton.addTarget(self, action: #selector(simulateButtonTapped), for: .touchUpInside)
        view.addSubview(simulateButton)
    }

    @objc private func simulateButtonTapped() {
        let dummyPixels = [0, 128, 255, 0, 64, 128, 192, 255] // 임시 데이터

        ClassificationAPI.classify(pixels: dummyPixels) { result in
            DispatchQueue.main.async {
                if let result = result {
                    self.placements = [
                        "💡 분류 결과: \(result.result)",
                        "📢 메시지: \(result.message)"
                    ]
                } else {
                    self.placements = ["❌ 서버 응답 실패"]
                }
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = placements[indexPath.row]
        return cell
    }
}
