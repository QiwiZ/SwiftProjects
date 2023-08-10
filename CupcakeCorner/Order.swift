//
//  Order.swift
//  CupcakeCorner
//
//  Created by Julian Saxl on 2023-07-21.
//

import Foundation

class Order: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case order
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(order, forKey: .order)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        order = try container.decode(OrderObject.self, forKey: .order)
    }
    
    init() { }
    
    struct OrderObject: Codable {
        static let types = ["Vanilla", "Chocolate", "Mint", "Strawberry"]
        
        var type = 0
        var amount = 3
        
        var specialRequestEnabled = false {
            didSet {
                if specialRequestEnabled == false {
                    extraFrosting = false
                    addSprinkles = false
                }
            }
        }
        
        var extraFrosting = false
        var addSprinkles = false
        
        var name = ""
        var streetAddress = ""
        var city = ""
        var zip = ""
        
        
        var hasValidAdress: Bool {
            !(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
              streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
              city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
              zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        
        var cost: Double {
            var cost = Double(amount) * 2
            cost += (Double(type) / 2)
            
            if extraFrosting {
                cost += Double(amount)
            }
            
            if addSprinkles {
                cost += Double(amount) / 2
            }
            return cost
        }
    }
    
    @Published var order = OrderObject()
    
}
