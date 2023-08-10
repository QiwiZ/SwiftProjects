//
//  CrewView.swift
//  Moonshot
//
//  Created by Julian Saxl on 2023-07-16.
//

import SwiftUI

struct CrewView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let crewMembers: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.crewMembers = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("There is no astronaut with name \(member.name)")
            }
            
        }
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(crewMembers, id:\.role) { member in
                    NavigationLink {
                        AstronautView(astronaut: member.astronaut)
                    } label: {
                        HStack {
                            Image(member.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.secondary)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(member.astronaut.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(member.role)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }.padding(.horizontal)
                }
            }
        }
    }
}

struct CrewView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        CrewView(mission: missions[1], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
