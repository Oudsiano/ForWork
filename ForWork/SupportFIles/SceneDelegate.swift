import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // MARK: UISceneDelegate
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Создаем окно
        window = UIWindow(windowScene: windowScene)
        
        // Создаем навигационный контроллер с корневым контроллером авторизации
        let navigationController = UINavigationController(rootViewController: LoginViewController())
        
        // Устанавливаем корневой контроллер окна
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    // Остальные методы UISceneDelegate можно оставить без изменений
}
