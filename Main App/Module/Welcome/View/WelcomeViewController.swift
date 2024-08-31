import UIKit

class WelcomeViewController: UIViewController {
    
    private var viewModel: WelcomeViewModel?
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "ico"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать!"
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 44, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.text = "Авторизуйтесь, что бы продолжить работу"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var signInButton: CustomButton = {
        let button = CustomButton(title: "Вход")
        button.backgroundColor = UIColor(named: "Yellow")
        return button
    }()
    private lazy var signUpButton: CustomButton = {
        let button = CustomButton(title: "Регистрация")
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    private lazy var inviteButton: CustomButton = {
        let button = CustomButton(title: "Пригласить управлять своим домом",
                                  systemImage: "house")
        let color = UIColor(named: "Blue")
        button.setInsets()
        button.tintColor = color
        button.setTitleColor(color, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = WelcomeViewModel()
        
        AuthService.shared.requestDashboard(
            username: "test_user",
            password: "123456aB",
            completion: { result in
                
            })
        
        setupView()
    }
    
    private func setupView() {
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(subLabel)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        view.addSubview(inviteButton)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            inviteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            inviteButton.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            inviteButton.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            
            signUpButton.bottomAnchor.constraint(equalTo: inviteButton.topAnchor, constant: -20),
            signUpButton.leadingAnchor.constraint(equalTo: inviteButton.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: inviteButton.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            signInButton.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -20),
            signInButton.leadingAnchor.constraint(equalTo: inviteButton.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: inviteButton.trailingAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            
            subLabel.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: -20),
            subLabel.leadingAnchor.constraint(equalTo: inviteButton.leadingAnchor),
            subLabel.trailingAnchor.constraint(equalTo: inviteButton.trailingAnchor),
            
            titleLabel.bottomAnchor.constraint(equalTo: subLabel.topAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: inviteButton.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: inviteButton.trailingAnchor),
        ])
        
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        
    }
    
    @objc private func signInButtonPressed() {
        guard let vc = viewModel?.createAuthController() else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

