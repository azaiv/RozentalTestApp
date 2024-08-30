import UIKit

class CustomTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 25, left: 50, bottom: 25, right: 50)
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.backgroundColor = .systemBackground
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.tintColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let hidePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular, scale: .default)
        button.setImage(UIImage(systemName: "eye.slash", withConfiguration: imageConfig), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash", withConfiguration: imageConfig), for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let borderLayer = CALayer()
    
    private var passIsHidden: Bool = true
    
    
    init(placeholder: String,
         systemImage: String,
         isPassword: Bool = false) {
        placeholderLabel.text = " \(placeholder) "
        imageView.image = UIImage(systemName: systemImage)
        super.init(frame: .zero)
        
        setupView(isPassword: isPassword)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        placeholderLabel.textColor = self.isEditing ? .black : .systemGray
        imageView.tintColor = self.isEditing ? .black : .systemGray
        hidePasswordButton.tintColor = self.passIsHidden ? .black : .systemGray
        borderLayer.borderColor = self.isEditing ? UIColor(named: "Yellow")?.cgColor : UIColor.systemGray5.cgColor
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        addBorder(borderWidth: 1, borderColor: .black)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    private func setupView(isPassword: Bool) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholderLabel.layer.zPosition = 2
        
        self.addSubview(placeholderLabel)
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor),
            placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
        ])
        
        if isPassword {
            self.isSecureTextEntry = passIsHidden
            self.addSubview(hidePasswordButton)
            
            NSLayoutConstraint.activate([
                hidePasswordButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                hidePasswordButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
            ])
            
            hidePasswordButton.addTarget(self, action: #selector(hidePasswordTapped), for: .touchUpInside)
        }
    }
    
    func addBorder(borderWidth: CGFloat = 1.0, borderColor: UIColor = UIColor.blue) {
        
        let frame = self.frame
        borderLayer.frame = CGRect(x: 0, y: placeholderLabel.frame.height / 2, width: frame.size.width, height: frame.size.height - 15)
        borderLayer.cornerRadius = 8
        borderLayer.cornerCurve = .continuous
        borderLayer.borderColor = UIColor.systemGray5.cgColor
        borderLayer.borderWidth = 1
        borderLayer.zPosition = 1
        self.layer.addSublayer(borderLayer)
    }
    
    @objc private func hidePasswordTapped() {
        passIsHidden.toggle()
        self.isSecureTextEntry = passIsHidden
    }

 
}

