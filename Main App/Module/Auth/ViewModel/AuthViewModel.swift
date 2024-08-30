import UIKit

protocol AuthViewModelProtocol {
    var email: String { get set }
    var password: String { get set }
    
    func signInButtonPassed(completion: @escaping ((Bool) -> ()))
}

final class AuthViewModel: AuthViewModelProtocol {
    
    var email: String = ""
    var password: String = ""
    
    private let authService = AuthService.shared
    
    func signInButtonPassed(completion: @escaping ((Bool) -> ())) {
        authService.authenticateAndGetDashboard(
            username: email,
            password: password, completion: { result in
                switch result {
                case .success(let responseModel):
                    print(responseModel)
                    completion(true)
                case .failure(let failure):
                    completion(false)
                }
            })
    }
    
    
}
