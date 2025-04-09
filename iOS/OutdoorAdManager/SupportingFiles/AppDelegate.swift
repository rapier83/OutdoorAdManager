import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // ✅ Core Data Stack 추가
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "OutdoorAdManagerModel") // ⚠️ 모델 이름 정확히!
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("❌ Core Data 로드 실패: \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        return true
    }

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
