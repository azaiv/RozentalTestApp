import Foundation

enum AuthServiceError: Error {
    case invalidCredentials
    case noData
}

final class AuthService {
    
    static let shared = AuthService()
    
    private let backgroundQueue = DispatchQueue(label: "backgroundTasksQueue", qos: .background)
    
    private init() { }
    
    func authenticateAndGetDashboard(
        username: String,
        password: String,
        completion: @escaping (Bool) -> Void) {
            
            var request = URLRequest(url: URL(string: Constants.URL.auth)!)
            request.httpMethod = "POST"
            
            let loginString = "\(username):\(password)"
            guard let loginData = loginString.data(using: .utf8) else {
                completion(false)
                return
            }
            let base64LoginString = loginData.base64EncodedString()
            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
            
            let authParameters: [String: Any] = [
                "service[0][name]": "login",
                "service[0][attributes][login]": username,
                "service[0][attributes][password]": password,
                "service[1][name]": "customer_navbar"
            ]
            
            let boundary = "Boundary-\(UUID().uuidString)"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = createMultipartBody(with: authParameters, boundary: boundary)
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(false)
                    return
                }
                
                guard let data = data else {
                    completion(false)
                    return
                }
                
                completion(true)
                
            }
            
            task.resume()
        }
    
    func requestDashboard(
        username: String,
        password: String,
        completion: @escaping (Result<MainData, Error>) -> Void) {
            
            backgroundQueue.async {
                
                var request = URLRequest(url: URL(string: Constants.URL.auth)!)
                request.httpMethod = "POST"
                
                let loginString = "\(username):\(password)"
                guard let loginData = loginString.data(using: .utf8) else {
                    DispatchQueue.main.async {
                        completion(.failure(AuthServiceError.invalidCredentials))
                    }
                    return
                }
                let base64LoginString = loginData.base64EncodedString()
                request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
                
                let dashboardParameters: [String: Any] = [
                    "service[0][name]": "customer_dashboard",
                    "service[1][name]": "my_profile",
                    "service[2][name]": "my_new_notifications",
                    "service[2][attributes][mode]": "private"
                ]
                
                let boundary = "Boundary-\(UUID().uuidString)"
                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                request.httpBody = self.createMultipartBody(with: dashboardParameters, boundary: boundary)
                
                let session = URLSession.shared
                
                let task = session.dataTask(with: request) { data, response, error in
                    if let error = error {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                        return
                    }
                    
                    guard let data = data else {
                        DispatchQueue.main.async {
                            completion(.failure(AuthServiceError.noData))
                        }
                        return
                    }
                    
                    do {
                        let dashboardResponse = try JSONDecoder().decode(MainData.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(dashboardResponse))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                }
                
                task.resume()
                
            }
        }
    
    private func createMultipartBody(with parameters: [String: Any], boundary: String) -> Data {
        var body = Data()
        
        for (key, value) in parameters {
            if let boundaryData = "--\(boundary)\r\n".data(using: .utf8) {
                body.append(boundaryData)
            }
            
            if let dispositionData = "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8) {
                body.append(dispositionData)
            }
            
            if let valueData = "\(value)".data(using: .utf8) {
                body.append(valueData)
            }
            
            if let newLineData = "\r\n".data(using: .utf8) {
                body.append(newLineData)
            }
        }
        
        if let closingBoundaryData = "--\(boundary)--\r\n".data(using: .utf8) {
            body.append(closingBoundaryData)
        }
        
        return body
    }
}
