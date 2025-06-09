//
//  MapView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/06/09.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        Map(position: $position) {
            if locationManager.isAuthorized {
                UserAnnotation()
            }
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
        }
        .ignoresSafeArea()
        .onAppear {
            locationManager.requestPermission()
        }
        .alert("位置権限が必要です", isPresented: .constant(!locationManager.isAuthorized && locationManager.hasRequestedPermission)) {
            Button("設定を開く") {
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
            Button("キャンセル", role: .cancel) { }
        } message: {
            Text("地図上にあなたの位置を表示するために、位置情報へのアクセスを許可してください。")
        }
    }
}

#Preview {
    MapView()
}
