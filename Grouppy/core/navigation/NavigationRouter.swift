import SwiftUI

final class NavigationRouter: ObservableObject {
  @Published var path: [Route] = []

  func navigate(to route: Route) {
    path.append(route)
  }

  func pop() {
    path.removeLast()
  }
}
