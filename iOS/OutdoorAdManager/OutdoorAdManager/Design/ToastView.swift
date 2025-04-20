//
//  ToastView.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/19/25.
//


import UIKit

class ToastView: UILabel {
    init(message: String) {
        super.init(frame: .zero)
        self.text = message
        self.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.textColor = .white
        self.textAlignment = .center
        self.font = .systemFont(ofSize: 14)
        self.numberOfLines = 0
        self.alpha = 0
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setContentHuggingPriority(.required, for: .vertical)
        self.setContentHuggingPriority(.required, for: .horizontal)
        self.setContentCompressionResistancePriority(.required, for: .vertical)
        self.setContentCompressionResistancePriority(.required, for: .horizontal)
        self.textInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var textInsets = UIEdgeInsets.zero

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    func show(in parent: UIView, duration: TimeInterval = 2.0) {
        parent.addSubview(self)
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: parent.centerXAnchor),
            bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            widthAnchor.constraint(lessThanOrEqualToConstant: 250)
        ])
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: duration, options: [], animations: {
                self.alpha = 0
            }, completion: { _ in
                self.removeFromSuperview()
            })
        }
    }
}