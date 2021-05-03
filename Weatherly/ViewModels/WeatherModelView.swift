//
//  WeatherModelView.swift
//  Weatherly
//
//  Created by Noam Efergan on 01/05/2021.
//

import SwiftUI

public class WeatherModelView: ObservableObject {

    // MARK: - Observable Variables

    @Published var isLoading      = false
    @Published var isAlertShowing = false
    @Published var isOnCelcius    = true

    // MARK: - Presentable variables
    ///All Most have default values that will be changed when API response is back

    @Published var name: String               = "London"
    @Published var region: String             = "City of London, Greater London"
    @Published var country: String            = "United Kingdom"
    @Published var condition: String          = "--"
    @Published var tempTitle: String          = Constants.cel
    @Published var temp: String               = "--"
    @Published var errorText: String          = Constants.errorSomethingWentWrong
    @Published var iconURL: URL               = URL(string: "https://cdn.weatherapi.com/weather/64x64/day/113.png")!
    @Published var buttonLabel: String        = Constants.cel
    @Published var days: [DayDisplayObject] = []

    // MARK: - Non observable variables

    private var forecastDays: [ForecastResponse] = []
    private var celcius    = "--"
    private var fahrenheit = "--"
    private let service    = WeatherService()

    // MARK: - API Service methods

    func getWeather() {
        self.isLoading = true
        service.getWeatherData(location: "Paris") { [weak self] weather, error in
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
                this.errorText = Constants.errorSomethingWentWrong
                this.isAlertShowing = true
                return
            }
            // Setting the data in the variables
            this.setData(data: data)
        }
    }

    private func setData(data: Weather) {
        isAlertShowing = false
        name = data.location.name
        region = data.location.region
        country = data.location.country

        celcius = "\(data.temperature.temp_c)"
        fahrenheit = "\(data.temperature.temp_f)"

        condition = data.temperature.condition.text
        forecastDays = data.forecast.forecastday
        updateTitles()
        if let url = URL(string: "https:" + data.temperature.condition.icon) { iconURL = url }
    }

    func updateTitles() {
        isOnCelcius.toggle()
        buttonLabel = isOnCelcius ? Constants.cel : Constants.far
        temp = isOnCelcius ? celcius : fahrenheit
        tempTitle = isOnCelcius ? Constants.temp_C : Constants.temp_F
        setDisplayItems()
    }

    private func setDisplayItems() {
        days.removeAll()
        for forecaseDay in self.forecastDays {
            let day = DayDisplayObject(isOnCelcius: isOnCelcius, day: forecaseDay.day)
            days.append(day)
        }
    }

}
