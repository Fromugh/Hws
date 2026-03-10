//
//  ContentView.swift
//  RpsGame
//
//  Created by H. Sungjae on 3/8/26.
//

import SwiftUI

struct ContentView: View {
    
    let choices = ["Rock", "Paper", "Scissors"]
    @State private var winOrlose: Bool = Bool.random()
    
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
