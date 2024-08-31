import Foundation


struct MainData: Codable {
    let myNewNotifications: Int
    let customerDashboard: CustomerDashboard
    let myProfile: MyProfile
    let code: Int

    enum CodingKeys: String, CodingKey {
        case myNewNotifications = "my_new_notifications"
        case customerDashboard = "customer_dashboard"
        case myProfile = "my_profile"
        case code
    }
}


struct CustomerDashboard: Codable {
    let date: String
    let notifications: Notifications
    let menuItems: [MenuItem]
    let banners: [Banner]
    let services: [Service]
    let navbar: [NavbarItem]

    enum CodingKeys: String, CodingKey {
        case date
        case notifications
        case menuItems = "menu_items"
        case banners
        case services
        case navbar
    }
}


struct Notifications: Codable {
    let count: Int
}


struct MenuItem: Codable {
    let action: String
    let name: String
    let description: String
    let arrear: String?
    let amountCoins: Int?
    let expected: Expected?

    enum CodingKeys: String, CodingKey {
        case action
        case name
        case description
        case arrear
        case amountCoins = "amount_coins"
        case expected
    }
}


struct Expected: Codable {
    let lastDate: String
    let indications: [Indication]

    enum CodingKeys: String, CodingKey {
        case lastDate = "last_date"
        case indications
    }
}


struct Indication: Codable {
    let type: String
    let label: String
    let lastTransfer: String
    let expected: Bool

    enum CodingKeys: String, CodingKey {
        case type
        case label
        case lastTransfer = "last_transfer"
        case expected
    }
}


struct Banner: Codable {
    let title: String
    let text: String
    let image: String
    let action: String
    let priority: Int
}


struct Service: Codable {
    let name: String
    let action: String
    let order: Int
}


struct NavbarItem: Codable {
    let name: String
    let action: String
}


struct MyProfile: Codable {
    let id: String
    let name: String
    let shortName: String
    let firstName: String
    let lastName: String
    let secondName: String
    let email: String
    let phone: String
    let photo: String
    let property: String
    let address: String
    let rating: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case shortName = "short_name"
        case firstName = "first_name"
        case lastName = "last_name"
        case secondName = "second_name"
        case email
        case phone
        case photo
        case property
        case address
        case rating
    }
}
