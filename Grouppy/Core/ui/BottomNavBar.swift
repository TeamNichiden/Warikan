import SwiftUI

struct BottomNavBar: View {
    @EnvironmentObject var router: NavigationRouter
    var selected: Route
    @Namespace private var animation

    let NAV_BAR_HEIGHT: CGFloat = 80

    var body: some View {
        VStack(spacing: 0) {
            Divider()
            HStack(spacing: 0) {
                tabItem(route: .home, icon: "house.fill", label: "ホーム")
                tabItem(route: .eventList, icon: "person.3.fill", label: "イベント")
                tabItem(route: .history, icon: "clock.arrow.circlepath", label: "履歴")
                tabItem(route: .setting, icon: "gearshape.fill", label: "設定")
            }
            .frame(height: NAV_BAR_HEIGHT)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.white, Color(.systemGray6)]),
                    startPoint: .top, endPoint: .bottom
                )
            )
            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: -2)
        }
    }

    @ViewBuilder
    private func tabItem(route: Route, icon: String, label: String) -> some View {
        let isSelected = (selected == route)
        let selectedColor = Color(red: 66/255, green: 133/255, blue: 244/255) // #4285F4
        let unselectedColor = Color(red: 102/255, green: 102/255, blue: 102/255) // #666666
        let iconSize: CGFloat = isSelected ? 34 : 28

        Button(action: {
            if selected != route {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    router.navigate(to: route)
                }
            }
        }) {
            VStack(spacing: 4) {
                ZStack {
                    if isSelected {
                        Circle()
                            .fill(selectedColor.opacity(0.12))
                            .frame(width: 48, height: 48)
                            .matchedGeometryEffect(id: "circle", in: animation)
                    }
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: iconSize, height: iconSize)
                        .foregroundColor(isSelected ? selectedColor : unselectedColor)
                        .scaleEffect(isSelected ? 1.15 : 1.0)
                        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isSelected)
                }
                Text(label)
                    .font(.custom("Inter", size: 11).weight(isSelected ? .bold : .regular))
                    .foregroundColor(isSelected ? selectedColor : unselectedColor)
                    .scaleEffect(isSelected ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 0.2), value: isSelected)
                // アンダーライン
                ZStack {
                    if isSelected {
                        Capsule()
                            .fill(selectedColor)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "underline", in: animation)
                            .padding(.horizontal, 16)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                    } else {
                        Color.clear.frame(height: 3)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}
