//
//  ContentView.swift
//  Weatherly
//
//  Created by Noam Efergan on 01/05/2021.
//

import SwiftUI

struct MainView: View {

    // MARK: - Variables

    @ObservedObject var viewModel = WeatherModelView()

    // MARK: - Main View

    var body: some View {
        /// The progress view should be in a Z stack and always forwards
        ActivityIndicator(isAnimating: .constant(viewModel.isLoading), style: .medium)
//        alert(isPresented: .constant(viewModel.isAlertShowing), content: {
//            Alert(
//                title: Text("Whoops!"),
//                message: Text(viewModel.errorText)
//            )
//        })
        Button("Testing") {
            viewModel.getWeather()
            print("test button clicked")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: WeatherModelView())
    }
}
