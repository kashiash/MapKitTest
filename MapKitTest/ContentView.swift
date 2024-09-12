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

        Map(initialPosition: .camera(MapCamera(
            centerCoordinate: CLLocationCoordinate2D(latitude: 50.280944,  longitude: 18.994181),
            distance: 1000,
            heading: 0,
            pitch: 0
        ))) {
            Annotation("Annotation", coordinate: CLLocationCoordinate2D(latitude: 50.28199,  longitude: 18.99360)) {
                Image(systemName: "flag")
                    .padding(.all, 8)
                    .background(RoundedRectangle(cornerRadius: 5).fill(.yellow))
            }

            Marker("Marker", coordinate: CLLocationCoordinate2D(latitude: 50.280944,  longitude: 18.994181))
                .tint(.red)

            MapCircle(center: CLLocationCoordinate2D(latitude: 50.280944,  longitude: 18.994181), radius: 180)
                .foregroundStyle(.yellow.opacity(0.2))

//            MapPolygon(coordinates: [
//                CLLocationCoordinate2D(latitude: 50.280950, longitude: 18.994275),
//                CLLocationCoordinate2D(latitude: 50.280800, longitude: 18.994275),
//                CLLocationCoordinate2D(latitude: 50.280800, longitude: 18.994181),
//                CLLocationCoordinate2D(latitude: 50.280950, longitude: 18.994181)
//            ])
//            .foregroundStyle(.brown)
        }
     //   .mapStyle(.standard(pointsOfInterest: []))
        .mapStyle(.hybrid(elevation: .realistic, pointsOfInterest: [.park, .parking], showsTraffic: true))
        .onAppear {
            print(CLLocationManager().authorizationStatus.rawValue)
        }
        .mapControls {
            MapCompass()
            MapPitchToggle()
            MapScaleView()
            MapUserLocationButton()
          //  MapZoomStepper()
          //  MapPitchSlider()
        }
    }
}

#Preview {
    ContentView()
}
