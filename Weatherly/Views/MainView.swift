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

        ZStack {
            /// Add gardient here
            VStack {
                HStack {
                    VStack {
                        //City title
                        HStack {
                            Text(viewModel.name)
                                .font(.system(size: Constants.titleFontSize))
                                .padding(.leading)
                            Spacer()
                            Button(viewModel.buttonLabel) {
                                viewModel.updateTitles()
                            }
                            .padding(.trailing)
                        }
                        HStack {
                            // Region
                            Text(Constants.region)
                                .padding(.leading)
                                .font(.system(size: Constants.regionTitleFontSize))
                            Text(viewModel.region)
                                .font(.system(size: Constants.regionDescriptionFontSize))
                            Spacer()
                        }
                        HStack {
                            // Country
                            Text(Constants.country)
                                .padding(.leading)
                                .font(.system(size: Constants.countryTitleFontSize))
                            Text(viewModel.country)
                                .font(.system(size: Constants.countryDescriptionFontSize))
                            Spacer()
                        }
                        Spacer()
                        VStack {
                            // Condition
                            Text(viewModel.condition)
                                .font(.system(size: Constants.conditionFontSize))
                            // Icon
                            ImageView(url: viewModel.iconURL)
                                .frame(
                                    width: Constants.mainIconFrameSize,
                                    height: Constants.mainIconFrameSize
                                )
                        }
                        Spacer()
                        HStack {
                            // Temps in cel
                            Text(viewModel.tempTitle)
                                .padding(.leading)
                                .font(.title3)
                            Text(viewModel.temp)
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            ForEach(0..<viewModel.days.count, id: \.self, content: { i in
                                let day = viewModel.days[i]
                                VStack {
                                    Text(day.minTemp)
                                }
                            }
                            )
                        }
                    }
                        Spacer()
                    }

                }
                ActivityIndicator(isAnimating: .constant(viewModel.isLoading), style: .large)
            }.onAppear() {
                viewModel.getWeather()
            }.alert(isPresented: .constant(viewModel.isAlertShowing), content:
                        {
                            Alert(title:Text( Constants.errorTitle), message: Text(viewModel.errorText), dismissButton: .default(Text(Constants.dismissButton)))
                        }
            )
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            MainView(viewModel: WeatherModelView())
        }
    }
