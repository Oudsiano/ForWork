import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: UIApplicationDelegate
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Создаем окно
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Создаем навигационный контроллер с корневым контроллером авторизации
        let navigationController = UINavigationController(rootViewController: LoginViewController())
        
        // Устанавливаем корневой контроллер окна
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    // Остальные методы UIApplicationDelegate можно оставить без изменений
}
