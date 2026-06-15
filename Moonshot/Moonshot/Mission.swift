//
//  Mission.swift
//  Moonshot
//
//  Created by H. Sungjae on 3/27/26.
//

import Foundation

struct Mission: Hashable, Codable, Identifiable {
    struct CrewRole: Hashable, Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    var image: String {
        "apollo\(id)"
    }
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
