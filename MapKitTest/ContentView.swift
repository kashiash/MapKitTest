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
  //  @State private var selection: MapSelection<Int>?
    @State private var searchResultItems: [MKMapItem] = []

    @State private var selection: MapFeature? = nil
    @State private var lookAroundScene: MKLookAroundScene?

    var body: some View {
        Map(position: $position, selection: $selection) {
            ForEach(searchResultItems, id: \.self) { item in
                Marker(item: item)
            }
        }
        .onMapCameraChange { context in
            self.region = context.region
        }
        .overlay(alignment: .topLeading, content: {
            VStack(spacing: 16) {
                Button{
                    Task{
                        if let sosnowiec = await findSosnowiec() {
                            self.position = .region(    MKCoordinateRegion(center: sosnowiec.placemark.coordinate, latitudinalMeters: 500, longitudinalMeters: 500))
                        }
                    }
                } label : {
                    Text("Find Sosnowiec and GO!")
                             .foregroundStyle(.white)
                             .padding(.all, 8)
                             .background(RoundedRectangle(cornerRadius: 4).fill(.gray))

                }

                Button(action: {
                    Task {
                        if let region = self.region {
                            let resorts = await findAtm(in: region)
                            self.searchResultItems = resorts
                        }
                    }
                }, label: {
                    Text("ATM")
                        .foregroundStyle(.white)
                        .padding(.all, 8)
                        .background(RoundedRectangle(cornerRadius: 4).fill(.gray))
                })
                Button(action: {
                    Task {
                        if let region = self.region {
                            let restaurants = await findRestaurants(in: region)
                            self.searchResultItems = restaurants
                        }
                    }
                }, label: {
                    Text("Find Restaurants")
                        .foregroundStyle(.white)
                        .padding(.all, 8)
                        .background(RoundedRectangle(cornerRadius: 4).fill(.gray))
                })


            }
        })
        .overlay(alignment: .top, content: {
            if let selection = selection {
                LookAroundView(selection: selection)
                    .frame(height: 256)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
            }
        })
    }
    private func findSosnowiec() async -> MKMapItem? {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Sosnowiec"
        request.addressFilter = .includingAll

        let search = MKLocalSearch(request: request)
        let response = try? await search.start()

        return response?.mapItems.first
    }
    private func findAtm(in region: MKCoordinateRegion) async -> [MKMapItem] {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "atm"
        request.region = region
        request.regionPriority = .default
        request.pointOfInterestFilter = MKPointOfInterestFilter(including: [.atm,.bank])

        let search = MKLocalSearch(request: request)
        let response = try? await search.start()
        return response?.mapItems ?? []
    }

    private func findRestaurants(in region: MKCoordinateRegion) async -> [MKMapItem] {
        let request = MKLocalPointsOfInterestRequest(coordinateRegion: region)
        request.pointOfInterestFilter = MKPointOfInterestFilter(including: [.restaurant])

        let search = MKLocalSearch(request: request)
        let response = try? await search.start()
        return response?.mapItems ?? []
    }
}

#Preview {
    ContentView()
}
