//
//  MapView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/06/09.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = MapViewModel()
    
    var body: some View {
        ZStack {
            MapReader { reader in
                Map(position: $vm.position) {
                    if vm.locationManager.isAuthorized {
                        UserAnnotation()
                    }
                    
                    // 显示用户选择的图钉
                    if let selectedPosition = vm.selectedPosition {
                        Annotation("選択した場所", coordinate: selectedPosition) {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.red)
                                .font(.title)
                                .background(Circle().fill(Color.white))
                        }
                    }
                }
                .mapControls {
                    MapUserLocationButton()
                    MapCompass()
                }
                .onTapGesture { location in
                    // 使用MapReader进行精确的坐标转换
                    if let coordinate = reader.convert(location, from: .local) {
                        vm.updateSelectedPosition(coordinate)
                    }
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            vm.locationManager.requestPermission()
        }
        .alert("位置権限が必要です", isPresented: .constant(!vm.locationManager.isAuthorized && vm.locationManager.hasRequestedPermission)) {
            Button("設定を開く") {
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
            Button("キャンセル", role: .cancel) { }
        } message: {
            Text("地図上にあなたの位置を表示するために、位置情報へのアクセスを許可してください。")
        }
        .overlay(alignment: .topTrailing) {
            Button {
                // 点击确定后返回到AddNewEventView
                if let position = vm.selectedPosition {
                    print(position.latitude)
                    print(position.longitude)
                }
                dismiss()
            } label: {
                Text("確定")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(vm.selectedPosition != nil ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(vm.selectedPosition == nil)
            .padding()
        }
        .overlay(alignment: .bottom) {
            // 显示选中位置的信息
            if let selectedPosition = vm.selectedPosition {
                VStack(alignment: .leading) {
                    Text("選択した位置")
                        .font(.headline)
                    Text("緯度: \(String(format: "%.6f", selectedPosition.latitude))")
                    Text("経度: \(String(format: "%.6f", selectedPosition.longitude))")
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding()
            }
        }
    }
}

#Preview {
    MapView()
}
