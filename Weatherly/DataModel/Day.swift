//
//  Day.swift
//  Weatherly
//
//  Created by Noam Efergan on 02/05/2021.
//

import Foundation

struct Day: Codable {
    let maxtemp_c           : Decimal
    let mintemp_c           : Decimal
    let avgtemp_c           : Decimal

    let maxtemp_f           : Decimal
    let mintemp_f           : Decimal
    let avgtemp_f           : Decimal

    let daily_chance_of_rain: String
    let condition           : Condition
}
