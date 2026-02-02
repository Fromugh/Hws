//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by H. Sungjae on 1/13/26.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    
    var body: some View {
        Button("Show Alert") {
            showingAlert = true
        }
        .alert("Important message", isPresented: $showingAlert) {
            Button("Delete", role: .destructive) { }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Please read this")
        }
        
    }
}

#Preview {
    ContentView()
}
