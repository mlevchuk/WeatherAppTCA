//
//  WeatherManager.swift
//  WeatherAppTCA
//
//  Created by Mykhaylo Levchuk on 06/02/2023.
//

import Foundation
import CoreLocation
import Dependencies

final class WeatherManager {
    private let apiKey = "46c58cab604acc3cf2fbbe5faf1a0c03"
    
    func gerCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)") else {
            fatalError("Not valid URL")
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching weather data")
        }
        
        let responseBody = try JSONDecoder().decode(ResponseBody.self, from: data)
        return responseBody
    }
    
    func getCurrentWeather(_ city: String) async throws -> ResponseBody {
        let validCity = city.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(validCity)&appid=\(apiKey)") else {
            fatalError("Not valid URL")
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NSError(domain: "Not valid status code", code: 1)
        }
        
        let responseBody = try JSONDecoder().decode(ResponseBody.self, from: data)
        return responseBody
    }
}

extension WeatherManager: DependencyKey {
    static var liveValue: WeatherManager { .init() }    
}

extension DependencyValues {
    var weatherManager: WeatherManager {
        get { self[WeatherManager.self] }
        set { self[WeatherManager.self] = newValue }
    }
}
