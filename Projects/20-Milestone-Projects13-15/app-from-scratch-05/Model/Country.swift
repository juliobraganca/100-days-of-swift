//
//  Country.swift
//  app-from-scratch-05
//
//  Created by Julio Braganca on 25/05/23.
//

import Foundation

struct Country: Codable {
    let capital: [String]
    let code: String
    let name: CountryName
    let population: Int
    let region: String
    let subregion: String
    
    var id: String {
        name.common
    }
    
    var flagImageName: String {
        code.lowercased()
    }
    
    private enum CodingKeys: String, CodingKey {
        case capital
        case code = "cca2"
        case name
        case population
        case region
        case subregion
    }
    
    struct CountryName: Codable {
        let common: String
        let official: String
    }
    
    static let countryCodes = [
        "ad", "ar", "be", "bf", "br", "bw", "ca", "ch", "ci", "cm",
        "co", "cz", "de", "dk", "ec", "fi", "fr", "gb", "gn", "in",
        "it", "jp", "kr", "lb", "lt", "lu", "ma", "md", "mx", "nf",
        "nz", "pl", "rw", "se", "sj", "sn", "td", "us", "uy", "ve"
    ]
}
