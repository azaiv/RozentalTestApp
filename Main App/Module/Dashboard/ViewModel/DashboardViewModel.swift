import Foundation

protocol DashboardViewModelProtocol {
    
    var data: MainData? { get }
    
    func getData(completion: @escaping (Bool) -> Void)
    
}

final class DashboardViewModel: DashboardViewModelProtocol {
    
    var data: MainData?
    
    func getData(completion: @escaping (Bool) -> Void) {
        AuthService.shared.requestDashboard(
            username: "test_user",
            password: "123456aB",
            completion: { result in
                switch result {
                case .success(let data):
                    self.data = data
                    completion(true)
                case .failure(let failure):
                    completion(false)
                }
            })
    }
    
}
