//
//  ContentView.swift
//  Free
//
//  Created by H. Sungjae on 5/4/26.
//

import SwiftUI

struct ContentView: View {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
//        NavigationStack {
//            ScrollView {
//                LazyVGrid(columns: columns) {
//                    ForEach(missions) { mission in
//                        NavigationLink {
//                            MissionView(mission: mission, astronauts: astronauts)
//                        } label: {
//                            VStack {
//                                Image(mission.image)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 100, height: 100)
//                                    .padding()
//                                
//                                VStack {
//                                    Text(mission.displayName)
//                                        .font(.headline)
//                                        .foregroundStyle(.white)
//                                    Text(mission.formattedLaunchDate)
//                                        .font(.caption)
//                                        .foregroundStyle(.white.opacity(0.5))
//                                }
//                                .padding(.vertical)
//                                .frame(maxWidth: .infinity)
//                                .background(.lightBackground)
//                            }
//                            .clipShape(.rect(cornerRadius: 10))
//                            .overlay (
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(.lightBackground)
//                            )
//                        }
//                    }
//                }
//                .padding([.horizontal, .bottom])
//            }
//            .navigationTitle("Moonshot")
//            .preferredColorScheme(.dark)
//            .scrollIndicators(.hidden)
//        }
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink(value: mission) {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay (
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .preferredColorScheme(.dark)
            .scrollIndicators(.hidden)
            .navigationDestination(for: Mission.self) { mission in
                MissionView(mission: mission, astronauts: astronauts)
            }
        }
    }
}

#Preview {
    ContentView()
}
