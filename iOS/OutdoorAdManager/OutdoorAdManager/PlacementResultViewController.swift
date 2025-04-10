//
//  PlacementResultViewController.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/10/25.
//

import UIKit

class PlacementResultViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("🟢 ViewController 화면 로딩됨!")

        let label = UILabel()
        label.text = "광고 관리자 화면 🎉"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
