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
            centerCoordinate: CLLocationCoordinate2D(latitude: 50.28199, longitude: 18.994181),
            distance: 800,
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
    @State private var selection: MapFeature? = nil
    @State private var selectedTag: Int?

    var body: some View {

        Map(initialPosition: initialPosition, selection: $selectedTag) {

            Marker("Orange", coordinate: CLLocationCoordinate2D(latitude: 50.28199,  longitude: 18.99360))
                .tint(.orange)
                .tag(1)

            Marker("Red", coordinate: CLLocationCoordinate2D(latitude: 50.280944,  longitude: 18.994181))
                .tint(.red)
                .tag(2)

        }
      //  .mapStyle(.standard(pointsOfInterest: []))
      //  .mapStyle(.imagery(elevation: .realistic))
      //  .mapStyle(.hybrid(elevation: .realistic, pointsOfInterest: [.park, .parking], showsTraffic: true))
        .mapStyle(.standard(emphasis: .muted))
    }
}

#Preview {
    ContentView()
}
