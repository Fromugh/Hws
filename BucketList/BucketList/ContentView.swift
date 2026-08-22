//
//  ContentView.swift
//  BucketList
//
//  Created by H. Sungjae on 7/29/26.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        if viewModel.isUnlocked {
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Button {
                                viewModel.selectedPlace = location
                            } label: {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 33, height: 33)
                                    .background(.white)
                                    .clipShape(.circle)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .onTapGesture { position in
                    // convert method turns a prozy's coordinate type value into CLLocationCoordinate2D type value.
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.addLocation(at: coordinate)
                    }
                }
                .sheet(item: $viewModel.selectedPlace) { place in
                    EditView(location: place) {
                        viewModel.update(location: $0)
                    }
                }
            }
        }
        else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .foregroundStyle(.blue)
                .clipShape(.capsule)

        }
    }
}

#Preview {
    ContentView()
}
 
