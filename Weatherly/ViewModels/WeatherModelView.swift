//
//  WeatherModelView.swift
//  Weatherly
//
//  Created by Noam Efergan on 01/05/2021.
//

import SwiftUI
import CoreLocation

public class WeatherModelView: NSObject, ObservableObject, CLLocationManagerDelegate {

    // MARK: - Observable Variables

    @Published var isLoading      = false
    @Published var isAlertShowing = false
    @Published var isOnCelcius    = true

    // MARK: - Presentable variables

    @Published var name: String               = Constants.empty
    @Published var region: String             = Constants.empty
    @Published var country: String            = Constants.empty
    @Published var condition: String          = Constants.empty
    @Published var tempTitle: String          = Constants.empty
    @Published var temp: String               = Constants.empty
    @Published var errorText: String          = Constants.errorSomethingWentWrong
    @Published var iconURL: URL               = URL(string: "https://cdn.weatherapi.com/weather/64x64/day/113.png")!
    @Published var buttonLabel: String        = Constants.cel
    @Published var days: [DayDisplayObject]   = []
    @Published var searchText: String         = "" { didSet {
        handleSearchBarResults(text: searchText)
    }}

    // MARK: - Non observable variables

    private var forecastDays: [ForecastResponse] = []
    private var celcius                          = Constants.empty
    private var fahrenheit                       = Constants.empty
    private let service                          = WeatherService()

    // MARK: - API Service methods

    /// Getting the user's location and calling the weather API
    func getLocation() {
        if LocationManager.shared.didUserAllow {
            isLoading = true
            LocationManager.shared.getLocation { [weak self] city, error in
                guard let this = self else { fatalError() }
                this.isLoading = false
                // If an error happened, let the user know and stop the operation.
                if error != nil {
                    // Force unwrapping because we know it isn't nil
                    this.errorText = error!
                    this.isAlertShowing = true
                    return
                }
                guard let location = city else {
                    this.errorText = Constants.errorSomethingWentWrong
                    this.isAlertShowing = true
                    return
                }
                this.getWeather(city: location)
            }
        } else {
            LocationManager.shared.askForAuth()
            LocationManager.shared.didAllowLocation = { [weak self] didAllow in
                self?.didChangePermission(allowed: didAllow)
            }
        }
    }

    /// Hitting the weather API and setting data
    private func getWeather(city: String) {
        self.isLoading = true
        service.getWeatherData(location: city) { [weak self] weather, error in
            // Capture self to prevent memory leaks
            guard let this = self else { fatalError() }
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

    // MARK: - Private helper methods

    ///Called when the callback is being called, when the user changes their location privacy setting
    private func didChangePermission(allowed: Bool) {
        allowed ? getLocation() : getWeather(city: Constants.defaultCity)
    }

    ///Setting the data received by the API in the variables
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

    /// Create and add display items, add those to the Forecast days array
    private func setDisplayItems() {
        days.removeAll()
        for forecaseDay in self.forecastDays {
            let day = DayDisplayObject(isOnCelcius: isOnCelcius, day: forecaseDay.day)
            days.append(day)
        }
    }


    /// Handles the text entered by the user
    /// - Parameter text: String value of the search bar
    private func handleSearchBarResults(text: String) {
        if text.isEmpty {
            errorText = Constants.emptySearch
            isAlertShowing = true
            return
        }
        getWeather(city: text)
    }

    // MARK: - Public helper methods

    /// Updating the string of the titles
    func updateTitles() {
        isOnCelcius.toggle()
        buttonLabel = isOnCelcius ? Constants.cel : Constants.far
        temp = isOnCelcius ? celcius : fahrenheit + Constants.degree
        tempTitle = isOnCelcius ? Constants.temp_C : Constants.temp_F
        setDisplayItems()
    }
}
