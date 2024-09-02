import UIKit

protocol AuthViewModelProtocol {
    var email: String { get set }
    var password: String { get set }
    
    func signInButtonPassed(completion: @escaping ((Bool) -> ()))
    func setDashboardViewModel() -> DashboardViewModelProtocol
}

final class AuthViewModel: AuthViewModelProtocol {
    
    private var mainData: MainData? = nil

    var email: String = ""
    var password: String = ""
    
    private let authService = AuthService.shared
    
    func signInButtonPassed(completion: @escaping ((Bool) -> ())) {
        authService.authenticateAndGetDashboard(
            username: email,
            password: password, completion: { isSuccess in
                if isSuccess {
                    self.authService.requestDashboard(
                        username: self.email,
                        password: self.password, completion: { result in
                            switch result {
                            case .success(let data):
                                self.mainData = data
                                completion(true)
                            case .failure( _):
                                completion(false)
                            }
                        })
                } else {
                    completion(false)
                }
    
            })
    }
    
    func setDashboardViewModel() -> any DashboardViewModelProtocol {
        let viewModel = DashboardViewModel(data: self.mainData)
        return viewModel
    }
    
    
}
