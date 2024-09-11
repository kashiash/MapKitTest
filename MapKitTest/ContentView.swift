//
//  ContentView.swift
//  MapKitTest
//
//  Created by Jacek Kosinski U on 11/09/2024.
//

import SwiftUI
import MapKit

struct ContentView: View {

    let initialPosition = MapCameraPosition.camera(
        MapCamera(
            centerCoordinate: CLLocationCoordinate2D(latitude: 50.2395, longitude: 19.0741),
            distance: 2000,
            heading: 0,
            pitch: 0
        )
    )

    let userLocation = MapCameraPosition.userLocation(fallback: MapCameraPosition.camera(
        MapCamera(
            centerCoordinate: CLLocationCoordinate2D(latitude: 50.2515, longitude: 19.0277),
            distance: 1000,
            heading: 0,
            pitch: 0)))

    let bounds = MapCameraBounds(
        centerCoordinateBounds: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 50.2812, longitude: 18.9975),
            latitudinalMeters: 1500,
            longitudinalMeters: 10500
        ),
        minimumDistance: 100,
        maximumDistance: 5000
    )

    var body: some View {

        Map(bounds: bounds) {

            Annotation("Stadion", coordinate: CLLocationCoordinate2D(latitude: 50.28819, longitude: 18.97358)) {
                Circle()
                    .fill(Color.red.opacity(0.3))
                    .frame(width: 300, height: 300)
            }

            Marker("Słonie", coordinate: CLLocationCoordinate2D(latitude: 50.28199,  longitude: 18.99360))
                .tint(.red)
        }
    }
}

#Preview {
    ContentView()
}
