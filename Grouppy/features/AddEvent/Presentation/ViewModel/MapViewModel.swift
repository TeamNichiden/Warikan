//
//  MapViewModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/06/09.
//

import SwiftUI
import MapKit

class MapViewModel: ObservableObject {
    @Published var locationManager = LocationManager()
    @Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var selectedPosition: CLLocationCoordinate2D?
    
    var locationState: LocationState // 共享的位置状态
    
    init(locationState: LocationState = LocationState()) {
        self.locationState = locationState
        // 同步初始值
        self.selectedPosition = locationState.selectedPosition
        
        // 监听 LocationState 的变化并同步到本地属性
        locationState.$selectedPosition
            .assign(to: &$selectedPosition)
    }
    
    // 当本地 selectedPosition 改变时，同步到 LocationState
    func updateSelectedPosition(_ position: CLLocationCoordinate2D?) {
        selectedPosition = position
        locationState.selectedPosition = position
    }
}
