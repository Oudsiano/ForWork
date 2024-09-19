import UIKit

class ChatView: UIView {
    let tableView = UITableView()
    let messageTextField = UITextField()
    let sendButton = UIButton(type: .system)
    let attachButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
        setupConstraints()
    }

    private func setupSubviews() {
        // Настройка элементов
        messageTextField.placeholder = "Введите сообщение"
        messageTextField.borderStyle = .roundedRect

        sendButton.setTitle("Отправить", for: .normal)
        attachButton.setTitle("Фото", for: .normal)

        // Добавление на View
        addSubview(tableView)
        addSubview(messageTextField)
        addSubview(sendButton)
        addSubview(attachButton)
    }

    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        messageTextField.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        attachButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // tableView
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageTextField.topAnchor, constant: -10),
            // messageTextField
            messageTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            messageTextField.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            messageTextField.heightAnchor.constraint(equalToConstant: 40),
            // attachButton
            attachButton.leftAnchor.constraint(equalTo: messageTextField.rightAnchor, constant: 5),
            attachButton.centerYAnchor.constraint(equalTo: messageTextField.centerYAnchor),
            attachButton.widthAnchor.constraint(equalToConstant: 50),
            // sendButton
            sendButton.leftAnchor.constraint(equalTo: attachButton.rightAnchor, constant: 5),
            sendButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            sendButton.centerYAnchor.constraint(equalTo: messageTextField.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
}
