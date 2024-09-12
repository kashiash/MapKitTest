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

    //50.290625, 18.991975
    static let planetary = MapCameraPosition.camera(MapCamera(
        centerCoordinate: CLLocationCoordinate2D(latitude: 50.290625, longitude: 18.991975),
        distance: 500,
        heading: 0,
        pitch: 0
    ))

    //50.296196, 18.767794
    static let stadium = MapCameraPosition.camera(MapCamera(
        centerCoordinate: CLLocationCoordinate2D(latitude: 50.296196, longitude: 18.767794),
        distance: 1000,
        heading: 0,
        pitch: 0
    ))

    @State private var selection: MapFeature? = nil
    @State private var selectedTag: Int?
    @State private var position: MapCameraPosition = Self.planetary

    @State private var centerCoordinate: CLLocationCoordinate2D? = Self.planetary.camera?.centerCoordinate

    var body: some View {
        Map(position: $position)
            .mapStyle(.imagery(elevation: .realistic))
            .overlay(alignment: .top, content: {
                HStack(spacing: 16) {
                    Button(action: {
                        position = Self.planetary
                    }, label: {
                        Text("Planetarium")
                            .font(.title3)
                            .foregroundStyle(.white)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 4).fill(.gray))
                    })

                    Button(action: {
                        position = Self.stadium
                    }, label: {
                        Text("Górnik Zabrze")
                            .font(.title3)
                            .foregroundStyle(.white)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 4).fill(.gray))
                    })
                }
                .fixedSize(horizontal: true, vertical: false)
                .padding(.all, 16)
            })
            .onMapCameraChange(frequency: .continuous) { context in
                self.centerCoordinate = context.region.center
            }
            .overlay(alignment: .bottomLeading, content: {
                if let centerCoordinate = centerCoordinate {
                    Text("\(centerCoordinate.latitude), \(centerCoordinate.longitude)")
                        .font(.title3)
                        .foregroundStyle(.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(RoundedRectangle(cornerRadius: 4).fill(.gray))
                        .padding(.all, 10)
                }
            })
    }
    
}

#Preview {
    ContentView()
}
