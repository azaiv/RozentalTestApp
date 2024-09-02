import Foundation

enum DashboardSections: CaseIterable {
    case messange
    case indications
    case banners
    case services
    case button
}

enum DashboardItem: Hashable {
    case message(count: Int)
    case indications(id: UUID,
                     menu: MenuItem)
    case banners(banner: [Banner])
    case services(service: [Service])
    case button(id: UUID)
}

struct DashboardSection: Hashable {
    let type: DashboardSections
    let item: [DashboardItem]
}
