//
//  AppDelegate.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/10/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = PlacementResultViewController() // 너의 시작 뷰컨
        self.window = window
        window.makeKeyAndVisible()

        print("✅ AppDelegate로 앱 시작됨!")
        return true
    }
}
