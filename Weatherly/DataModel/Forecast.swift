//
//  Forecast.swift
//  Weatherly
//
//  Created by Noam Efergan on 02/05/2021.
//

import Foundation

struct Forecast: Codable {
    let forecastday: [ForecastResponse]
}

struct ForecastResponse: Codable {
    let date: String
    let day : Day
}

struct ForecastDay: Codable {
    let day: [Day]
}
