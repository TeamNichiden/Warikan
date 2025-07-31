//
//  HomeView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/02.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: HomeViewModel
    @EnvironmentObject var route: NavigationRouter
    @EnvironmentObject var auth: AuthManager
    @State private var showingProfile = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // MARK: - HEADER SECTION
                headerSection
                
                // MARK: - RECENT EVENTS SECTION
                recentEventsSection
                
                // MARK: - QUICK ACTIONS SECTION
                quickActionsSection
                
                Spacer(minLength: 100)
            }
            .padding(.horizontal)
            .padding(.top, 10)
        }
        .background(Color(.systemGroupedBackground))
        .refreshable {
            // 添加下拉刷新功能
            await refreshData()
        }
        .environmentObject(vm)
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(spacing: 12) {
            HStack {
                MiniProfile(user: vm.user)
                    .onTapGesture {
                        showingProfile = true
                    }
                
                Spacer()
                
                editProfileButton
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.secondarySystemGroupedBackground))
                    .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
            )
            
            // 欢迎消息
            welcomeMessage
        }
    }
    
    private var editProfileButton: some View {
        Button {
            route.navigate(to: .editProfile)
        } label: {
            HStack(spacing: 6) {
                Image(systemName: "pencil")
                    .font(.system(size: 14, weight: .medium))
                Text("編集")
                    .font(.system(size: 14, weight: .medium))
            }
            .foregroundColor(.primary)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(Color(.tertiarySystemGroupedBackground))
                    .overlay(
                        Capsule()
                            .stroke(Color(.separator), lineWidth: 0.5)
                    )
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
    
    private var welcomeMessage: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("こんにちは、\(vm.user.name)さん")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("今日も素敵な一日を！")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.horizontal, 4)
    }
    
    // MARK: - Recent Events Section
    private var recentEventsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label("最近のイベント", systemImage: "calendar")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("すべて表示") {
                    route.navigate(to: .eventList)
                }
                .font(.caption)
                .foregroundColor(.blue)
            }
            
            ProximityEventView()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemGroupedBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
    
    // MARK: - Quick Actions Section
    private var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Label("クイックアクション", systemImage: "bolt.fill")
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                ActionCard(
                    icon: "plus.circle.fill",
                    title: "イベント作成",
                    subtitle: "新しいイベントを作成",
                    color: .blue,
                    action: { route.navigate(to: .addEvent) }
                )
                
                ActionCard(
                    icon: "list.bullet.circle.fill",
                    title: "イベント確認",
                    subtitle: "参加予定のイベント",
                    color: .green,
                    action: { route.navigate(to: .eventList) }
                )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemGroupedBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
    
    // MARK: - Helper Functions
    private func refreshData() async {
        // 实现数据刷新逻辑
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        // vm.refreshUserData()
        // vm.refreshEvents()
    }
}

// MARK: - Action Card Component
struct ActionCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(color)
                
                VStack(spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.tertiarySystemGroupedBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(color.opacity(0.3), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Extensions
extension View {
    func button(action: @escaping(() -> Void),
                title: String,
                textColor: Color,
                backgroundColor: Color
    ) -> some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(textColor)
                .fontWeight(.bold)
                .padding(18)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(backgroundColor)
                .cornerRadius(12)
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
