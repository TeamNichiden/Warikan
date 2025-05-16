import Foundation

enum Route: Hashable {
    case home
    case editProfile
    case addGroup
    case groupList
    case group(id: UUID)
}
