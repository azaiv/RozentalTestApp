import UIKit

protocol WelcomeViewModelProtocol {
    
    func createAuthController() -> UIViewController
    
}

final class WelcomeViewModel: WelcomeViewModelProtocol {
    
    func createAuthController() -> UIViewController {
        return AuthViewController()
    }

}
