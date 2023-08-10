//
//  MissionView.swift
//  Moonshot
//
//  Created by Julian Saxl on 2023-07-15.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronauts: [String: Astronaut]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    
                    Text(mission.formattedLaunchDate)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .accessibilityLabel("Launch date: \(mission.formattedLaunchDate)")
                    
                    VStack(alignment: .leading) {
                        HorizontalDeviderView()
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        HorizontalDeviderView()
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }.padding(.horizontal)
                    CrewView(mission: mission, astronauts: astronauts)
                    
                }.padding(.bottom)
            }
        }.navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
