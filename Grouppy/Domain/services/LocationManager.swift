//
//  LocationManager.swift
//  Grouppy
//
//  Created by cmStudent on 2025/06/09.
//

import SwiftUI
import MapKit
import Observation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var isAuthorized = false
    @Published var hasRequestedPermission = false
    
    override init() {
        super.init()
        manager.delegate = self
        checkAuthorizationStatus()
    }
    
    func requestPermission() {
        hasRequestedPermission = true
        manager.requestWhenInUseAuthorization()
    }
    
    private func checkAuthorizationStatus() {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            isAuthorized = true
        default:
            isAuthorized = false
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorizationStatus()
    }
}
