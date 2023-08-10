//
//  ContentView.swift
//  Moonshot
//
//  Created by Julian Saxl on 2023-07-13.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let mission: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    @State private var isGridLayout = true
    
    var body: some View {
        NavigationView {
            if isGridLayout {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(mission) { mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronauts)
                            } label: {
                                VStack {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding()
                                        .accessibilityHidden(true)
                                    
                                    VStack {
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(mission.formattedLaunchDate)
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.5))
                                            .accessibilityLabel("Launch date: \(mission.formattedLaunchDate)")
                                    }
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .background(.lightBackground)
                                }.clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.lightBackground))
                            }
                        }
                    }.padding([.horizontal, .bottom])
                }.navigationTitle("Moonshot")
                    .background(.darkBackground)
                    .preferredColorScheme(.dark)
                    .toolbar {
                        Button("Switch layout") {
                            isGridLayout.toggle()
                        }
                    }
            } else {
                List(mission) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()

                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }.clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.lightBackground))
                    }
                        .background(.darkBackground)
                }
                .navigationTitle("Moonshot")
                .listStyle(.plain)
                .listRowBackground(Color.darkBackground)
                .preferredColorScheme(.dark)
                .background(.darkBackground)
                .toolbar {
                    Button("Switch layout") {
                        isGridLayout.toggle()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
