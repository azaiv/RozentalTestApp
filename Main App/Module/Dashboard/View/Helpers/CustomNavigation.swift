import UIKit

final class CustomNavigation: UIView {
    
    private let userImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "1"))
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let userLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let addressButton: CustomButton = {
        let button = CustomButton(title: "")
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    private let notificationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bell"), for: .normal)
        button.setImage(UIImage(systemName: "bell"), for: .highlighted)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(name: String, address: String) {
        super.init(frame: .zero)
        
        setupView()
        
        self.userLabel.text = name
        self.addressButton.setTitle(address, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        backgroundColor = UIColor(named: "Blue")
        
        addSubview(userImage)
        addSubview(userLabel)
        addSubview(addressButton)
        addSubview(notificationButton)
        
        NSLayoutConstraint.activate([
            userImage.leadingAnchor.constraint(equalTo: self.readableContentGuide.leadingAnchor, constant: 10),
            userImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            userImage.heightAnchor.constraint(equalToConstant: 32),
            userImage.widthAnchor.constraint(equalToConstant: 32),
            
            userLabel.centerYAnchor.constraint(equalTo: userImage.centerYAnchor),
            userLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),
            
            addressButton.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: -5),
            addressButton.leadingAnchor.constraint(equalTo: userLabel.leadingAnchor),
            
            notificationButton.centerYAnchor.constraint(equalTo: userImage.centerYAnchor),
            notificationButton.trailingAnchor.constraint(equalTo: self.readableContentGuide.trailingAnchor, constant: -10)
        ])
    }
    
}
