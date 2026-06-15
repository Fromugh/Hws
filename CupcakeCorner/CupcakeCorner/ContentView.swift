//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by H. Sungjae on 6/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var results = [Result]()
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedRsponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedRsponse.results
            }
            
        } catch {
            print("Invalid data")
        }
    }
}

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

#Preview {
    ContentView()
}
