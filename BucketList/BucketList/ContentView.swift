//
//  ContentView.swift
//  BucketList
//
//  Created by H. Sungjae on 7/29/26.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    @State private var locations = [Location]()
    @State private var selectedPlace: Location?
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
        
    
    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Button {
                            selectedPlace = location
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
                    // Every time we tap where else, each locations stored inlocations array.
                    let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                    locations.append(newLocation)
                }
            }
            .sheet(item: $selectedPlace) { place in
                Text(place.name)
            }
        }
    }
}

#Preview {
    ContentView()
}
 
