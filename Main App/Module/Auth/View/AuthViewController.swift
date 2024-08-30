import UIKit

final class AuthViewController: UIViewController {
    
    private var viewModel: AuthViewModel!
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular, scale: .default)
        button.setImage(UIImage(systemName: "chevron.backward",
                                withConfiguration: imageConfig), for: .normal)
        button.setImage(UIImage(systemName: "chevron.backward",
                                withConfiguration: imageConfig), for: .highlighted)
        button.tintColor = .systemGray
        button.backgroundColor = .systemGray6
        return button
    }()
    private lazy var forgetPasswrod: CustomButton = {
        let button = CustomButton(title: "Забыли пароль?")
        button.setTitleColor(.systemGray, for: .normal)
        return button
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход в аккаунт"
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var loginTextField: CustomTextField = {
        let textfield = CustomTextField(
            placeholder: "E-mail",
            systemImage: "at")
        textfield.tag = 0
        textfield.delegate = self
        return textfield
    }()
    private lazy var passwordTextField: CustomTextField = {
        let textfield = CustomTextField(
            placeholder: "Пароль",
            systemImage: "lock",
            isPassword: true)
        textfield.tag = 1
        textfield.delegate = self
        return textfield
    }()
    private lazy var signInButton: CustomButton = {
        let button = CustomButton(title: "Вход")
        button.backgroundColor = UIColor(named: "Yellow")
        return button
    }()
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Ошибка! Проверьте логин и пароль или подклчение к интернету."
        label.numberOfLines = 0
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    private var topAnchorConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = AuthViewModel()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        
        topAnchorConstraint = signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
        
            loginTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            loginTextField.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            loginTextField.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            
            signInButton.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        topAnchorConstraint.isActive = true
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: forgetPasswrod)

        signInButton.isEnabled = !viewModel.email.isEmpty || !viewModel.password.isEmpty
        signInButton.backgroundColor = viewModel.email.isEmpty || viewModel.password.isEmpty ? .systemGray3 : UIColor(named: "Yellow")
        signInButton.addTarget(self, action: #selector(sigInButtonPressed), for: .touchUpInside)
        
        backButton.frame = .init(x: 0, y: 0, width: 30, height: 30)
        backButton.layer.cornerRadius = 15
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        hideKeyboardWhenTappedAround()
    }
    
    private func setupProgressView() {
        
        signInButton.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: signInButton.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: signInButton.frame.height),
            activityIndicator.widthAnchor.constraint(equalToConstant: signInButton.frame.width),
        ])
        
        activityIndicator.tintColor = .black
        activityIndicator.layer.cornerRadius = 8
        activityIndicator.layer.cornerCurve = .continuous
        activityIndicator.backgroundColor = UIColor(named: "Yellow")
        activityIndicator.startAnimating()
    }
    
    private func addErrorLabel() {
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            errorLabel.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
        ])
    }
    
    @objc private func sigInButtonPressed() {
        DispatchQueue.main.async {
            if self.view.subviews.contains(self.errorLabel) {
                UIView.animate(withDuration: 0.4, animations: {
                    self.errorLabel.removeFromSuperview()
                    self.topAnchorConstraint.constant = 20
                })
            }
            self.setupProgressView()
            self.signInButton.isEnabled = false
        }
        
        viewModel.signInButtonPassed(completion: { isSuccess in
            if isSuccess {
                DispatchQueue.main.async {
                    self.activityIndicator.removeFromSuperview()
                    self.signInButton.isEnabled = false
                    let vc = UINavigationController(rootViewController: UIViewController())
                    UIApplication.shared.keyWindow?.switchRootViewController(vc)
                }
            } else {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.4, animations: {
                        self.topAnchorConstraint.constant = 60
                        self.addErrorLabel()
                    })
                    self.activityIndicator.removeFromSuperview()
                    self.signInButton.isEnabled = true
                }
            }
        })
        
    }
    
    @objc private func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AuthViewController: UITextFieldDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.tag == 0 {
            viewModel.email = textView.text
        } else {
            viewModel.password = textView.text
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.tag == 0 {
            viewModel.email = textField.text ?? ""
        } else if textField.tag == 1 {
            viewModel.password = textField.text ?? ""
        }
        
        DispatchQueue.main.async {
            self.signInButton.isEnabled = !self.viewModel.email.isEmpty && !self.viewModel.password.isEmpty
            self.signInButton.backgroundColor = self.viewModel.email.isEmpty || self.viewModel.password.isEmpty ? .systemGray3 : UIColor(named: "Yellow")
        }
    }
    
}
