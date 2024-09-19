// Presenters/ChatPresenter.swift
import UIKit
import Photos

class ChatPresenter: NSObject, ChatPresenterProtocol {
    
    weak var view: ChatViewProtocol?
    var messages: [Message] = []
    
    init(view: ChatViewProtocol) {
        self.view = view
    }
    
    func loadMessages() {
        // Загрузка сообщений (можно реализовать загрузку с сервера)
        messages.append(Message(text: "Добро пожаловать!", image: nil, sender: "System", timestamp: Date()))
        view?.updateMessages()
    }
    
    func sendMessage(text: String) {
        // Создаём объект сообщения
        let message = Message(text: text, image: nil, sender: "User", timestamp: Date())
        
        // Добавляем сообщение в массив
        messages.append(message)
        
        // Обновляем интерфейс
        view?.updateMessages()
        
        // Шифруем и отправляем сообщение на сервер
        if let encryptedData = EncryptionManager.shared.encryptMessage(text) {
            // Отправляем encryptedData на сервер
            NetworkManager.shared.sendMessageData(encryptedData)
        } else {
            view?.showError("Не удалось зашифровать сообщение.")
        }
    }

    func didReceiveMessageData(_ data: Data) {
        if let decryptedMessage = EncryptionManager.shared.decryptMessage(data) {
            let message = Message(text: decryptedMessage, image: nil, sender: "Other", timestamp: Date())
            messages.append(message)
            view?.updateMessages()
        } else {
            view?.showError("Не удалось расшифровать сообщение.")
        }
    }

    
    func attachImage() {
        // Запрос доступа к фотографиям
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                self.presentImagePicker()
            default:
                DispatchQueue.main.async {
                    self.view?.showError("Доступ к фотографиям запрещен.")
                }
            }
        }
    }
    
    private func presentImagePicker() {
        DispatchQueue.main.async {
            if let viewController = self.view as? UIViewController {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                viewController.present(imagePicker, animated: true)
            }
        }
    }
    func attachPhotoFromCamera() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            if granted {
                self?.presentCamera()
            } else {
                DispatchQueue.main.async {
                    self?.view?.showError("Доступ к камере запрещён. Пожалуйста, разрешите доступ в настройках приложения.")
                }
            }
        }
    }

    private func presentCamera() {
        DispatchQueue.main.async {
            if let viewController = self.view as? UIViewController {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                viewController.present(imagePicker, animated: true)
            }
        }
    }
    func startRecordingAudio() {
        AVAudioSession.sharedInstance().requestRecordPermission { [weak self] granted in
            if granted {
                self?.startAudioRecording()
            } else {
                DispatchQueue.main.async {
                    self?.view?.showError("Доступ к микрофону запрещён. Пожалуйста, разрешите доступ в настройках приложения.")
                }
            }
        }
    }

    private func startAudioRecording() {
        // Реализация записи аудио
    }

}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension ChatPresenter: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else { return }
        
        let message = Message(text: nil, image: image, sender: "User", timestamp: Date())
        messages.append(message)
        view?.updateMessages()
        
        // Отправка изображения на сервер (асинхронно)
        // NetworkManager.shared.sendImage(image)
    }
}
