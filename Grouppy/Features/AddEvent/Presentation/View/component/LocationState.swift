import SwiftUI
import MapKit

class LocationState: ObservableObject {
    @Published var selectedPosition: CLLocationCoordinate2D?
}