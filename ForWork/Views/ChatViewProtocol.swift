// Views/ChatViewProtocol.swift

protocol ChatViewProtocol: AnyObject {
    func updateMessages()
    func showError(_ message: String)
}
