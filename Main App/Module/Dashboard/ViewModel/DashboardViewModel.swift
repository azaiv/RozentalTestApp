import Foundation

protocol DashboardViewModelProtocol {
    
    var data: MainData? { get }
    
}

final class DashboardViewModel: DashboardViewModelProtocol {
    
    var data: MainData?
    
    init(data: MainData? = nil) {
        self.data = data
    }

}
