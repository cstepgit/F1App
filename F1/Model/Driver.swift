//
//  Driver.swift
//  F1
//
//  Created by Cooper Stepanian on 4/20/25.
//

import Foundation


struct Driver: Codable {
    let driverId: String
    let permanentNumber: String  // API provides this as a string
    let code: String
    let url: URL
    let givenName: String
    let familyName: String
    let dateOfBirth: String
    let nationality: String
}
