//
//  WeatherView.swift
//  WeatherAppTCA
//
//  Created by Mykhaylo Levchuk on 03/02/2023.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
        
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherContentView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.gerCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
