//
//  DriverStandings.swift
//  F1
//
//  Created by Cooper Stepanian on 4/20/25.
//
struct DriverStanding: Codable, Identifiable {
    var id: String { driver.driverId }

    let position: String
    let positionText: String
    let points: String
    let wins: String
    let driver: Driver
    let constructors: [Constructor]

    enum CodingKeys: String, CodingKey {
        case position, positionText, points, wins
        case driver = "Driver"
        case constructors = "Constructors"
    }
}
