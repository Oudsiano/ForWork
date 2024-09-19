// Views/Cells/ChatMessageCell.swift

import UIKit

class ChatMessageCell: UITableViewCell {
    
    private let messageLabel = UILabel()
    private let messageImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(messageLabel)
        contentView.addSubview(messageImageView)
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            messageImageView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8),
            messageImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            messageImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            messageImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            messageImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with message: Message) {
        messageLabel.text = message.text
        messageImageView.image = message.image
        messageImageView.isHidden = message.image == nil
    }
}
