//
//  DayDisplayObject.swift
//  Weatherly
//
//  Created by Noam Efergan on 03/05/2021.
//

import SwiftUI

public class DayDisplayObject: ObservableObject {

    // MARK: - Non observable variables

    private var isOnCelcius: Bool = true
    private var day: Day?

    // MARK: - Observable Variables

    @Published var minTemp: String = Constants.empty
    @Published var maxTemp: String = Constants.empty
    @Published var avgTemp: String = Constants.empty
    @Published var conditionString : String = Constants.empty
    @Published var chanceOfRain : String = Constants.empty
    @Published var iconURL: URL = URL(string: "www.apple.com")!

    // MARK: - Init method

    init(isOnCelcius: Bool, day: Day) {
        self.isOnCelcius = isOnCelcius
        self.day = day
        setData()
    }

    private func setData() {
        guard let data = day else { return }
        minTemp = isOnCelcius ? "\(data.mintemp_c)" : "\(data.mintemp_f)" + Constants.degree
        maxTemp = isOnCelcius ? "\(data.maxtemp_c)" : "\(data.maxtemp_f)" + Constants.degree
        avgTemp = isOnCelcius ? "\(data.avgtemp_c)" : "\(data.avgtemp_f)" + Constants.degree
        conditionString = data.condition.text
        chanceOfRain = data.daily_chance_of_rain
        iconURL = getDailyIcon(day: data)
    }


    private func getDailyIcon(day: Day) -> URL {
        let urlString = "https:" + day.condition.icon
        if let url = URL(string: urlString) { return url }
        else { return self.iconURL }
    }


}
