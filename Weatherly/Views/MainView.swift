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
            LinearGradient(gradient: Constants.backgroundGradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                SearchBar(text: $viewModel.searchText)
                VStack {
                    HStack {
                        // Stack for the location info
                        ZStack {
                            LinearGradient(gradient: Constants.containerGradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                                .opacity(0.15)
                            VStack {
                                //City title
                                HStack {
                                    Text(viewModel.name)
                                        .font(.system(size: Constants.titleFontSize))
                                        .padding(.leading)
                                        .foregroundColor(.white)
                                    Spacer()
                                    // Change metric button
                                    Button(viewModel.buttonLabel) {
                                        viewModel.updateTitles()
                                    }
                                    .padding(.trailing)
                                    .foregroundColor(.white)
                                }
                                HStack {
                                    // Region
                                    Text(Constants.region)
                                        .padding(.leading)
                                        .font(.system(size: Constants.regionTitleFontSize))
                                        .foregroundColor(.white)
                                    Text(viewModel.region)
                                        .font(.system(size: Constants.regionDescriptionFontSize))
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                HStack {
                                    // Country
                                    Text(Constants.country)
                                        .padding(.leading)
                                        .font(.system(size: Constants.countryTitleFontSize))
                                        .foregroundColor(.white)
                                    Text(viewModel.country)
                                        .font(.system(size: Constants.countryDescriptionFontSize))
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .frame(
                        width: UIScreen.main.bounds.width - 20,
                        height: 160
                    )
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 8)
                    // Closing the VStack of the top compartment
                    Spacer()
                    ZStack {
                        LinearGradient(gradient: Constants.containerGradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                            .opacity(0.15)
                        VStack {
                            Spacer()
                            // Condition
                            Text(viewModel.condition)
                                .font(.system(size: Constants.conditionFontSize))
                                .foregroundColor(.white)
                            // Icon
                            ImageView(url: viewModel.iconURL)
                                .frame(
                                    width: Constants.mainIconFrameSize,
                                    height: Constants.mainIconFrameSize
                                )
                            HStack {
                                // Temps in cel
                                Text(viewModel.tempTitle)
                                    .padding(.leading)
                                    .font(.title3)
                                    .foregroundColor(.white)
                                Text(viewModel.temp)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }
                    }
                    .frame(
                        width: UIScreen.main.bounds.width - 20,
                        height: 250
                    )
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 8)
                    Spacer()
                    //Closing the middle container stack
                    // Bottom forecast view
                    ZStack {
                        LinearGradient(gradient: Constants.containerGradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                            .opacity(0.15)
                        HStack {
                            ForEach(0..<viewModel.days.count, id: \.self, content: { i in
                                let day = viewModel.days[i]
                                // Individual forecast view
                                VStack {
                                    ImageView(url: viewModel.iconURL)
                                        .frame(
                                            width: Constants.forecastIconFrameSize,
                                            height: Constants.forecastIconFrameSize
                                        )
                                    Text(Constants.min + day.minTemp)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                        .foregroundColor(.white)
                                    Text(Constants.max + day.maxTemp)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                        .foregroundColor(.white)
                                    Text(Constants.avg + day.avgTemp)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                        .foregroundColor(.white)
                                    Text(day.conditionString)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                        .foregroundColor(.white)
                                }.padding(.horizontal)
                            }
                            )
                        }
                    }
                    .frame(
                        width: UIScreen.main.bounds.width - 20,
                        height: 170
                    )
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 8)
                    Spacer()
                    // Closing the bottom view container
                }
            }
            .opacity(viewModel.isLoading ? 0 : 1)
            VStack {
                ActivityIndicator(isAnimating: $viewModel.isLoading, style: .large)
                Text(Constants.loading).opacity(viewModel.isLoading ? 1 : 0)
                    .foregroundColor(.white)
            }
        }
        .onAppear() {
            viewModel.getLocation()
        }.alert(isPresented: $viewModel.isAlertShowing, content:
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
