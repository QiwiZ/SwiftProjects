//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Julian Saxl on 2023-08-30.
//

import SwiftUI

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        let opacity = (geo.frame(in: .global).minY - 50) / 100
                        let scaling = max(0.5, geo.frame(in: .global).minY / 700) 
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(colors[index % 7])
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(opacity)
                            .scaleEffect(scaling)
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
                    Text("Left")
                    GeometryReader { geo in
                        Text("Center")
                            .background(.blue)
                            .onTapGesture {
                                print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                                print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                                print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                            }
                    }
                    .background(.orange)
                    Text("Right")
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
