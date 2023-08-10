//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Julian Saxl on 2023-07-18.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

class User: Codable, ObservableObject {
    enum CodingKeys: CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container =  encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
    
    @Published var name = "Some name"
}

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.order.type) {
                        ForEach(Order.OrderObject.types.indices) {
                            Text(Order.OrderObject.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.order.amount)", value: $order.order.amount, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.order.specialRequestEnabled.animation())
                    
                    if order.order.specialRequestEnabled {
                        Toggle("Extra frosting?", isOn: $order.order.extraFrosting)
                        
                        Toggle("Sprinkles?", isOn: $order.order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
                
            }.navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
