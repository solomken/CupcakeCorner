//
//  Order.swift
//  CupcakeCorner
//
//  Created by Anastasiia Solomka on 13.07.2023.
//

import SwiftUI

class Order: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    @Published var specialRequestEnabled = false {
        didSet { // here we switch our toggles back to false state after changing main toggle specialRequestEnabled back to false state
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        let isNameEmpty = name.trimmingCharacters(in: .whitespaces).isEmpty
        let isStreetAddressEmpty = streetAddress.trimmingCharacters(in: .whitespaces).isEmpty
        let isCityEmpty = city.trimmingCharacters(in: .whitespaces).isEmpty
        let isZipEmpty = zip.trimmingCharacters(in: .whitespaces).isEmpty
        
        if isNameEmpty || isStreetAddressEmpty || isCityEmpty || isZipEmpty {
            return false
        } else {
            return true
        }
    }
    
    var cost: Double {
        //$2 per cake
        var cost = Double(quantity) * 2
        
        //complecated cakes cost more
        cost += (Double(type) / 2)
        
        //add $1 per cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        //add $0.5 for extra sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
    init() { }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
}
