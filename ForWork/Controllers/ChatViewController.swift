// Views/ChatViewController.swift

import UIKit

class ChatViewController: UIViewController, ChatViewProtocol {

    private let tableView = UITableView()
    private let messageInputBar = UIView()
    private let messageTextField = UITextField()
    private let sendButton = UIButton(type: .system)
    private let attachButton = UIButton(type: .system)
    
    var presenter: ChatPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupInputBar()    // Сначала вызываем это
        setupTableView()   // Затем вызываем это
        
        presenter = ChatPresenter(view: self)
        presenter.loadMessages()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: "ChatMessageCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageInputBar.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupInputBar() {
        messageInputBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageInputBar)
        
        messageInputBar.backgroundColor = .systemGray5
        
        messageTextField.placeholder = "Введите сообщение"
        messageTextField.translatesAutoresizingMaskIntoConstraints = false
        
        sendButton.setTitle("Отправить", for: .normal)
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        attachButton.setTitle("📎", for: .normal)
        attachButton.addTarget(self, action: #selector(attachButtonTapped), for: .touchUpInside)
        attachButton.translatesAutoresizingMaskIntoConstraints = false
        
        messageInputBar.addSubview(attachButton)
        messageInputBar.addSubview(messageTextField)
        messageInputBar.addSubview(sendButton)
        let cameraButton = UIButton(type: .system)
        cameraButton.setTitle("📷", for: .normal)
        cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
        cameraButton.translatesAutoresizingMaskIntoConstraints = false

        messageInputBar.addSubview(cameraButton)

        // Обновите ограничения
        NSLayoutConstraint.activate([
            cameraButton.leadingAnchor.constraint(equalTo: attachButton.trailingAnchor, constant: 8),
            cameraButton.centerYAnchor.constraint(equalTo: messageInputBar.centerYAnchor),
            cameraButton.widthAnchor.constraint(equalToConstant: 30),
            
            messageTextField.leadingAnchor.constraint(equalTo: cameraButton.trailingAnchor, constant: 8),
            // Остальные ограничения остаются прежними
        ])
        NSLayoutConstraint.activate([
            messageInputBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageInputBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageInputBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageInputBar.heightAnchor.constraint(equalToConstant: 50),
            
            attachButton.leadingAnchor.constraint(equalTo: messageInputBar.leadingAnchor, constant: 8),
            attachButton.centerYAnchor.constraint(equalTo: messageInputBar.centerYAnchor),
            attachButton.widthAnchor.constraint(equalToConstant: 30),
            
            sendButton.trailingAnchor.constraint(equalTo: messageInputBar.trailingAnchor, constant: -8),
            sendButton.centerYAnchor.constraint(equalTo: messageInputBar.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 80),
            
            messageTextField.leadingAnchor.constraint(equalTo: attachButton.trailingAnchor, constant: 8),
            messageTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8),
            messageTextField.centerYAnchor.constraint(equalTo: messageInputBar.centerYAnchor),
            messageTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func sendButtonTapped() {
        guard let text = messageTextField.text, !text.isEmpty else { return }
        presenter.sendMessage(text: text)
        messageTextField.text = ""
    }
    @objc private func cameraButtonTapped() {
        presenter.attachPhotoFromCamera()
    }
    @objc private func attachButtonTapped() {
        presenter.attachImage()
    }
    
    // MARK: - ChatViewProtocol
    
    func updateMessages() {
        tableView.reloadData()
        let indexPath = IndexPath(row: presenter.messages.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let message = presenter.messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageCell", for: indexPath) as! ChatMessageCell
        cell.configure(with: message)
        return cell
    }
}
