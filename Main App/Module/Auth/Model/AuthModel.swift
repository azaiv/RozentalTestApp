import Foundation

struct ResponseModel: Codable {
    let login: String
    let customerNavbar: [CustomerNavbar]
    let code: Int

    enum CodingKeys: String, CodingKey {
        case login
        case customerNavbar = "customer_navbar"
        case code
    }
}

struct CustomerNavbar: Codable {
    let name: String
    let action: String
}
