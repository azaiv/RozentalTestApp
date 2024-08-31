import Foundation

enum DashboardSections {
    case messange
    case indications
    case ads
    case horizontal
    case button
}

enum DashboardItem: Hashable {
    case messange
    case indications(id: UUID, image: String, title: String, sub: String)
    case ads
    case horizontal
    case button(id: UUID)
}

struct DashboardSection: Hashable {
    let type: DashboardSections
    let item: [DashboardItem]
}
