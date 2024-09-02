import UIKit

final class CustomNavigation: UIView {
    
    private let userImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "1"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 17.5
        imageView.backgroundColor = .systemGray5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let userLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressButton: UIButton = {
        let button = UIButton(type: .system)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 8, weight: .medium, scale: .default)
        button.setImage(UIImage(systemName: "chevron.down", withConfiguration: imageConfig), for: .normal)
        button.setImage(UIImage(systemName: "chevron.down", withConfiguration: imageConfig), for: .highlighted)
        button.imageEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: 0)
        button.setTitleColor(.white, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
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
    
    init(name: String, 
         address: String,
         url: String) {
        
        super.init(frame: .zero)
        
        setupView()
        
        self.userLabel.text = name
        self.addressButton.setTitle(address, for: .normal)
        self.loadImage(from: url, into: self.userImage)
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
            userImage.leadingAnchor.constraint(equalTo: self.readableContentGuide.leadingAnchor, constant: 5),
            userImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            userImage.heightAnchor.constraint(equalToConstant: 35),
            userImage.widthAnchor.constraint(equalToConstant: 35),
            
            userLabel.centerYAnchor.constraint(equalTo: userImage.centerYAnchor, constant: -5),
            userLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),
            
            addressButton.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 2),
            addressButton.leadingAnchor.constraint(equalTo: userLabel.leadingAnchor),
            
            notificationButton.centerYAnchor.constraint(equalTo: userImage.centerYAnchor),
            notificationButton.trailingAnchor.constraint(equalTo: self.readableContentGuide.trailingAnchor, constant: -10)
        ])
    }
    
    private func loadImage(from url: String, into imageView: UIImageView) {
        guard let imageURL = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let data = data,
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
        
        task.resume()
    }
    
}
