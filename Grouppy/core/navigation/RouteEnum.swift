import Foundation

enum Route: Hashable {
    case editProfile
    case addGroup
    case groupList
    case group(id: UUID)
}
