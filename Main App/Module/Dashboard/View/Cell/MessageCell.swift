import UIKit

final class MessageCell: UITableViewCell {
    
    static let stringID = "MessageCell"
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .systemBackground
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.layer.borderWidth = 0.5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dotView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .systemGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    func configure(count: Int) {
        
        selectionStyle = .none
        
        contentView.addSubview(backView)
        contentView.addSubview(dotView)
        backView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.readableContentGuide.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            titleLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            
            dotView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            dotView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -15),
            dotView.widthAnchor.constraint(equalToConstant: 8),
            dotView.heightAnchor.constraint(equalToConstant: 8)
        ])
        
        titleLabel.text = "\(count) сообщений от УК"
        dotView.backgroundColor = count > 0 ? .systemRed : .systemGreen
        
    }
    
}
