//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by H. Sungjae on 7/3/26.
//

import SwiftUI; import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
