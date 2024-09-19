// Presenters/LoginPresenter.swift

import UIKit

class LoginPresenter: LoginPresenterProtocol {
    
    weak var view: LoginViewProtocol?
    
    init(view: LoginViewProtocol) {
        self.view = view
    }
    
    func login(username: String, password: String) {
        // Валидация введенных данных
        if username.isEmpty || password.isEmpty {
            view?.showError("Пожалуйста, введите имя пользователя и пароль.")
            return
        }
        
        // Создание пользователя
        let user = User(username: username, password: password)
        
        // Здесь можно добавить логику проверки пользователя (например, отправка на сервер)
        
        // Для примера считаем, что логин успешен
        loginSuccess()
    }
    
    private func loginSuccess() {
        DispatchQueue.main.async {
            let chatViewController = ChatViewController()
            if let viewController = self.view as? UIViewController {
                viewController.navigationController?.pushViewController(chatViewController, animated: true)
            }
        }
    }
}
