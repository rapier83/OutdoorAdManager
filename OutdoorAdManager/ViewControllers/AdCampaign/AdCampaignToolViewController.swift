//
//  AdCampaignToolViewController.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/20/25.

import UIKit

class AdCampaignToolViewController: UIViewController {

    private var recommendations: [Recommendation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "캠페인 도구"
        setupLayout()
        setupToolbar()
    }

    private func setupLayout() {
        let label = UILabel()
        label.text = "여기는 캠페인 관련 도구를 위한 화면입니다."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func insertSampleCampaigns() {
        SampleDataLoader.shared.insertSampleAdCampaigns()
        let toast = ToastView(message: "샘플 캠페인 생성 완료")
        toast.show(in: self.view)
    }
    
    @objc private func resetCampaignData() {
        SampleDataLoader.shared.resetAllData()
        let toast = ToastView(message: "전체 캠페인 초기화 완료")
        toast.show(in: self.view)
    }
    
    @objc private func runRecommendation() {
        RecommendationService.shared.fetchRecommendations(siteId: 3) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    print("📡 추천 결과 \(items.count)개 수신됨")
                    self.recommendations = items
                    ToastView(message: "추천 완료, 결과 보기 버튼을 눌러주세요.").show(in: self.view)

                case .failure(let error):
                    print("❌ 추천 실패: \(error)")
                    ToastView(message: "❌ 추천 실패: \(error.localizedDescription)").show(in: self.view)
                }
            }
        }
    }

    private func setupToolbar() {
        let loadButton = UIBarButtonItem(title: "샘플 캠페인", style: .plain, target: self, action: #selector(insertSampleCampaigns))
        let resetButton = UIBarButtonItem(title: "초기화", style: .plain, target: self, action: #selector(resetCampaignData))
        let recommendButton = UIBarButtonItem(title: "추천 실행", style: .plain, target: self, action: #selector(runRecommendation))
        let resultButton = UIBarButtonItem(title: "결과 보기", style: .plain, target: self, action: #selector(showRecommendationResult))
        toolbarItems = [loadButton, .flexibleSpace(), resetButton, .flexibleSpace(), recommendButton, .flexibleSpace(), resultButton]
        navigationController?.isToolbarHidden = false
    }
    
    @objc private func showRecommendationResult() {
        let resultVC = RecommendationResultViewController()
        resultVC.recommendations = recommendations
        present(UINavigationController(rootViewController: resultVC), animated: true, completion: nil)
    }
    
}
