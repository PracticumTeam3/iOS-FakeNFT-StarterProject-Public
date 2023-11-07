import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Public properties
    var orientationLock = UIInterfaceOrientationMask.all

    // MARK: - Private properties
    private static var isUITestingEnabled: Bool {
        ProcessInfo.processInfo.arguments.contains("UI-Testing")
    }

    // MARK: - Public methods
    func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?
    ) -> UIInterfaceOrientationMask {
        orientationLock
    }

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UINavigationBar.appearance().tintColor = UIColor(named: "black")
        setEnvironment()
        return true
    }

    func application(
        _: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    // MARK: - Private methods
    private func setEnvironment() {
        StorageService.shared.environment = Self.isUITestingEnabled ? .test : .prod
    }

}
