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
    static let defaultCity = "Cupertino"

    /// Temperature

    static let min: String = "Min: "
    static let max: String = "Max: "
    static let avg: String = "Average: "

    static let cel: String = "Celcius"
    static let far: String = "Fahrenheit"
    static let degree: String = "°"

    // MARK: -  UI Related Constants

    /// Titles

    static let region: String = "Region: "
    static let country: String = "Country: "
    static let temp_C: String = "Temperature in Celcius:"
    static let temp_F: String = "Temperature in Fahrenheit:"
    static let loading: String = "Loading..."
    static let empty: String = "--"
    static let placeholder: String = "Search for any city!"

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
    static let emptySearch: String = "Search value cannot be empty!"

    /// Gradients

    static let backgroundGradient: Gradient = Gradient(colors: [Color.init(#colorLiteral(red: 0.257717669, green: 0.7781383395, blue: 0.8628693223, alpha: 1)),Color.init(#colorLiteral(red: 0.3170586526, green: 0.2887242436, blue: 0.613643527, alpha: 1))])
    static let containerGradient: Gradient = Gradient(colors: [Color.init(#colorLiteral(red: 0.5201607347, green: 0.8455730677, blue: 0.8075823188, alpha: 1)),Color.init(#colorLiteral(red: 0.09286741167, green: 0.315694958, blue: 0.4711213708, alpha: 1))])
}
