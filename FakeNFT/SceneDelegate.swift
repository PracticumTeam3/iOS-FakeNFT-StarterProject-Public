import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let firstVC = LaunchScreenViewController()
        window?.rootViewController = firstVC
        window?.backgroundColor = A.Colors.whiteDynamic.color
        window?.makeKeyAndVisible()
    }
}
