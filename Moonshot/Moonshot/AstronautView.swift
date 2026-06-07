//
//  AstronautView.swift
//  Moonshot
//
//  Created by H. Sungjae on 6/7/26.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 20))
                    .padding(.horizontal, 5)
                
                Text(astronaut.description)
                    .padding()
                    
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    AstronautView(astronaut: astronauts["grissom"]!)
        .preferredColorScheme(.dark)
}
