import UIKit

class PlacementResultViewController: UIViewController, UITableViewDataSource {

    private let tableView = UITableView()
    private let simulateButton = UIButton(type: .system)
    private var placements: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print("✅ ViewController loaded!")

        view.backgroundColor = .white
        setupTableView()
        setupButton()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: simulateButton.topAnchor, constant: -20)
        ])
    }

    private func setupButton() {
        simulateButton.setTitle("시뮬레이션 실행", for: .normal)
        simulateButton.translatesAutoresizingMaskIntoConstraints = false
        simulateButton.addTarget(self, action: #selector(simulateButtonTapped), for: .touchUpInside)
        view.addSubview(simulateButton)

        NSLayoutConstraint.activate([
            simulateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            simulateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            simulateButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func simulateButtonTapped() {
        placements = [
            "강남역 - 08:00 ~ 10:00 - ₩1500",
            "홍대입구 - 18:00 ~ 20:00 - ₩1800"
        ]
        tableView.reloadData()
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = placements[indexPath.row]
        return cell
    }
}
