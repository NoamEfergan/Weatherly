//
//  Temperature.swift
//  Weatherly
//
//  Created by Noam Efergan on 01/05/2021.
//

import Foundation

struct Temperature: Codable {
    let temp_c    : Double
    let temp_f    : Double
    let condition : Condition
}

struct Condition: Codable {
    let text: String
    let icon: String
}
