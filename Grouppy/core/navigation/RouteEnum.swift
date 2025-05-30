import Foundation

enum Route: Hashable {
  case home
  case editProfile
  case addEvent
  case eventList
  case event(id: String)
  case history
  case setting
}
