//
//  Color.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/11/25.
//

import UIKit

struct Color {
    
    // MARK: - Primary Color
    static let ceruleanBlue = UIColor(hex: "#4EA8DE")  // 메인 브랜드 컬러
    
    // MARK: - Secondary Colors
    static let signalGreen = UIColor(hex: "#10B981")   // 성공, 긍정
    static let alertOrange = UIColor(hex: "#F97316")   // 경고, 주의
    static let criticalRed = UIColor(hex: "#EF4444")   // 오류, 중단

    // MARK: - Neutral Colors
    static let textPrimary = UIColor(hex: "#111827")   // 기본 텍스트
    static let textSecondary = UIColor(hex: "#374151") // 보조 텍스트
    static let divider = UIColor(hex: "#D1D5DB")       // 경계선
    static let background = UIColor(hex: "#F9FAFB")    // 배경
    static let cardBackground = UIColor(hex: "#FFFFFF")// 카드형 요소 배경

    // MARK: - Interaction Colors
    static let hoverBackground = UIColor(hex: "#E5E7EB") // 버튼 hover 등

    // MARK: - 버튼 등 액션 요소 전용 컬러
    static let primaryButtonBackground = ceruleanBlue
    static let primaryButtonText = UIColor.white
}

// MARK: - UIColor Hex Extension

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted.remove(at: hexFormatted.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
