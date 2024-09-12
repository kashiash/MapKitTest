//
//  ContentView.swift
//  MapKitTest
//
//  Created by Jacek Kosinski U on 11/09/2024.
//

import SwiftUI
import MapKit

struct ContentView: View {

    static let stadium = MapCameraPosition.camera(MapCamera(
        centerCoordinate: CLLocationCoordinate2D(latitude: 50.296196, longitude: 18.767794),
        distance: 1000,
        heading: 0,
        pitch: 0
    ))

    @State private var position: MapCameraPosition = Self.stadium
    @State private var region: MKCoordinateRegion? = Self.stadium.region
    @State private var selection: MapSelection<Int>?
    @State private var searchResultItems: [MKMapItem] = []

    var body: some View {
        Map(position: $position, selection: $selection) {
            ForEach(searchResultItems, id: \.self) { item in
                Marker(item: item)
            }
        }
        .onMapCameraChange { context in
            self.region = context.region
        }
    }

}

#Preview {
    ContentView()
}
