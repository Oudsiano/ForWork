// Presenters/ChatPresenterProtocol.swift

protocol ChatPresenterProtocol: AnyObject {
    var messages: [Message] { get }
    func loadMessages()
    func sendMessage(text: String)
    func attachImage()
    func attachPhotoFromCamera() // Добавьте эту строку
}

