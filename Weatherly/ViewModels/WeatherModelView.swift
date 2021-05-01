//
//  WeatherModelView.swift
//  Weatherly
//
//  Created by Noam Efergan on 01/05/2021.
//

import SwiftUI

public class WeatherModelView: ObservableObject {

    // MARK: - Observable Variables

    @Published var progressView = ProgressView("Loading...")
    @Published var isLoading = false
    @Published var isAlertShowing = false

    // MARK: - Presentable variables
    @Published var name: String = "--"
    @Published var region: String = "--"
    @Published var country: String = "--"
    @Published var condition: String = "--"
    @Published var celcius: String = "--"
    @Published var fahrenheit: String = "--"
    @Published var errorText: String = "--"

    // MARK: - Non observable variables

    let service = WeatherService()

    // MARK: - API Service methods

    func getWeather() {
        self.isLoading = true
        service.getWeatherData(location: "London") { [weak self] weather, error in
            // Capture self to prevent memory leaks
            guard let this = self else { return }
            this.isLoading = false
            // Checks if an error has happened
            if error != nil {
                this.errorText = error!
                this.isAlertShowing = true
                return
            }
            // Verifying that the response was parsed correctly
            guard let data = weather else {
                this.errorText = "Whoops! something went wrong. Let's try again!"
                this.isAlertShowing = true
                return
            }
            // Setting the data in the variables
            this.isAlertShowing = false

            this.name = data.location.name
            this.region = data.location.region
            this.country = data.location.country

            this.celcius = "\(data.temperature.temp_c)"
            this.fahrenheit = "\(data.temperature.temp_f)"
            this.condition = data.temperature.condition.text
        }
    }

}
