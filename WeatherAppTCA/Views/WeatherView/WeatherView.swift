//
//  WeatherView.swift
//  WeatherAppTCA
//
//  Created by Mykhaylo Levchuk on 03/02/2023.
//

import SwiftUI

struct WeatherView: View {
    let city: String
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            if let weather = weather {
                WeatherContentView(weather: weather)
            } else {
                LoadingView()
                    .task {
                        do {
                            weather = try await weatherManager.getCurrentWeather(city)
                        } catch {
                            print("Error getting weather: \(error)")
                        }
                    }
            }
        }
        .background(Constants.Colors.primary)
        .preferredColorScheme(.dark)
        .accentColor(Color.white)
        
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(city: "")
    }
}
