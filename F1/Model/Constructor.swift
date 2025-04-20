//
//  Driver.swift
//  F1App
//
//  Created by Cooper Stepanian on 4/20/25.
//

import Foundation

struct Constructor: Codable {
    let constructorId: String
    let url: URL
    let name: String
    let nationality: String

    enum CodingKeys: String, CodingKey {
        case constructorId, url, name, nationality
    }
}




