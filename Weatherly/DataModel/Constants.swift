//
//  Constants.swift
//  Weatherly
//
//  Created by Noam Efergan on 01/05/2021.
//

import SwiftUI

struct Constants {

    // API related constants

    static let baseAPIurl = "https://api.weatherapi.com/v1/forecast.json?key="

    // MARK: -  UI Related Constants

    /// Titles

    static let region: String = "Region: "
    static let country: String = "Country: "
    static let temp_C: String = "Temperature in Celcius:"
    static let temp_F : String = "Temperature in Fahrenheit:"

    static let minC: String = "Min temp in Celcius: "
    static let maxC: String = "Max temp in Celcius: "
    static let avgC: String = "Average temp in Celcius: "

    static let minF: String = "Min temp in Fahrenheit: "
    static let maxF: String = "Max temp in Fahrenheit: "
    static let avgF: String = "Average temp in Fahrenheit: "

    static let cel: String = "Celcius"
    static let far: String = "Fahrenheit"

    /// Font sizes

    static let titleFontSize: CGFloat = 50
    static let regionTitleFontSize : CGFloat = 25
    static let regionDescriptionFontSize : CGFloat = 20
    static let countryTitleFontSize: CGFloat = 20
    static let countryDescriptionFontSize: CGFloat = 15
    static let conditionFontSize: CGFloat = 40

    ///Image sizes

    static let mainIconFrameSize : CGFloat = 64
    static let forecastIconFrameSize : CGFloat  = 32

    /// Error strings

    static let errorTitle: String = "Whoops!"
    static let errorSomethingWentWrong: String = "something went wrong. Try again!"
    static let dismissButton: String = "Got it!"
}
