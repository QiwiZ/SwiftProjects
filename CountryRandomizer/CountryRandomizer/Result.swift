//
//  Result.swift
//  CountryRandomizer
//
//  Created by Julian Saxl on 2023-08-09.
//

import Foundation

struct Result: Codable {
    let metaData: MetaData
    let countries: [Country]
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        metaData = try container.decode(MetaData.self)
        countries = try container.decode([Country].self)
    }
}

struct MetaData: Codable {
    let page: Int
    let pages: Int
    let per_page: String
    let total: Int
}

struct Country: Codable, Comparable {
    static func == (lhs: Country, rhs: Country) -> Bool {
        lhs.id == rhs.id
    }
    
    static func < (lhs: Country, rhs: Country) -> Bool {
        lhs.name < rhs.name
    }
    
    let id: String
    let iso2Code: String
    let name: String
    let region: Subinformation
    let adminregion: Subinformation
    let incomeLevel: Subinformation
    let lendingType: Subinformation
    let capitalCity: String
    let longitude: String
    let latitude: String
    
    var wrappedLongitude: Double {
        Double(longitude) ?? 0.0
    }
    
    var wrappedLatitude: Double {
        Double(latitude) ?? 0.0
    }
}

struct Subinformation: Codable {
    let id: String
    let iso2code: String
    let value: String
}
