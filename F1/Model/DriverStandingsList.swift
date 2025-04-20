//
//  DriverStandingsList.swift
//  F1
//
//  Created by Cooper Stepanian on 4/20/25.
//

import Foundation


struct DriverStandingsList: Codable {
    let season: String
    let round: String
    let driverStandings: [DriverStanding]

    enum CodingKeys: String, CodingKey {
        case season, round
        case driverStandings = "DriverStandings"
    }
}
