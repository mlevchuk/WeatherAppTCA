//
//  WeatherContentView.swift
//  WeatherAppTCA
//
//  Created by Mykhaylo Levchuk on 06/02/2023.
//

import SwiftUI

struct WeatherContentView: View {
    var weather: ResponseBody
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .bold()
                        .font(.title)
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                    Spacer()
                    
                    VStack {
                        HStack {
                            VStack(spacing: 20) {
                                Image(systemName: "sun.max")
                                    .font(.system(size: 40))
                                Text(weather.weather[0].main)
                            }
                            .frame(width: 100, alignment: .leading)
                            Spacer()
                            Text(weather.main.feelsLike.roundDouble() + "°")
                                .font(.system(size: 70))
                                .fontWeight(.bold)
                                .padding()
                        }
                        Spacer()
                            .frame(height: 80)
                        AsyncImage(url: URL(string: "https://bst.icons8.com/wp-content/themes/icons8/app/uploads/2018/04/city-illustration.jpg")!) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300)
                                .clipShape(RoundedRectangle(cornerRadius: 60))
                        } placeholder: {
                            ProgressView()
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                 Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather now")
                        .bold()
                        .padding(.bottom)
                    HStack {
                        WeatherCharacteristicRow(logo: "thermometer", name: "Min temp", value: weather.main.tempMin.roundDouble() + "°")
                        Spacer()
                        WeatherCharacteristicRow(logo: "thermometer", name: "Max temp", value: weather.main.tempMax.roundDouble() + "°")
                    }
                    HStack {
                        WeatherCharacteristicRow(logo: "wind", name: "Wind speed", value: weather.wind.speed.roundDouble() + "m/s")
                        Spacer()
                        WeatherCharacteristicRow(logo: "humidity", name: "Humidity", value: String(weather.main.humidity) + "%")
                    }
                }
            
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Constants.Colors.primary)
                .background(Color.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Constants.Colors.primary)
        .preferredColorScheme(.dark)
    }
}

struct WeatherContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherContentView(weather: previewWeather)
    }
}
