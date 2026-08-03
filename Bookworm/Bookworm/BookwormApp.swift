//
//  BookwormApp.swift
//  Bookworm
//
//  Created by H. Sungjae on 6/24/26.
//

import SwiftUI; import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
