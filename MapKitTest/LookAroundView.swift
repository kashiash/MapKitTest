//
//  LookAroundView.swift
//  MapKitTest
//
//  Created by Jacek Kosinski U on 12/09/2024.
//

import SwiftUI
import MapKit

 struct LookAroundView: View {
    var selection: MapFeature
    @State private var lookAroundScene: MKLookAroundScene?

    var body: some View {
        LookAroundPreview(initialScene: lookAroundScene)
            .overlay(alignment: .bottomLeading, content: {
                if let title = selection.title {
                    HStack {
                        Text(title)
                    }
                    .font(.caption)
                    .foregroundStyle(.white)
                    .padding(.all, 8)
                    .background(RoundedRectangle(cornerRadius: 4).fill(.black))
                    .padding(.all, 8)
                }
            })
            .onChange(of: selection, initial: true, {
                getLookAroundScene()
            })
    }

    func getLookAroundScene() {
        lookAroundScene = nil
        Task {
            let request = MKLookAroundSceneRequest(coordinate: selection.coordinate)
            do {
                lookAroundScene = try await request.scene
                if lookAroundScene == nil {
                    print("Look Around Preview not available for the given coordinate.")
                }
            } catch (let error) {
                print(error)
            }
        }
    }
}

struct LookAroundBaseView: View {


    private let initialPosition = MapCameraPosition.camera(
        MapCamera(
            centerCoordinate: CLLocationCoordinate2D(latitude: 50.296196, longitude: 18.767794),
            distance: 300,
            heading: 0,
            pitch: 0
        )
    )

    @State private var selection: MapFeature? = nil
    @State private var lookAroundScene: MKLookAroundScene?


    var body: some View {
        Map(initialPosition: initialPosition, selection: $selection)
            .overlay(alignment: .top, content: {
                if let selection = selection {
                    LookAroundView(selection: selection)
                        .frame(height: 256)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
            })
    }
}

#Preview {
    LookAroundBaseView()
}
