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
        setEnvironment()
        UINavigationBar.appearance().tintColor = UIColor(named: "black")
        return true
    }

    func application(
        _: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        configuration.storyboard = nil
        configuration.sceneClass = UIWindowScene.self
        configuration.delegateClass = SceneDelegate.self
        return configuration
    }

    // MARK: - Private methods
    private func setEnvironment() {
        StorageService.shared.environment = Self.isUITestingEnabled ? .test : .prod
    }

}
