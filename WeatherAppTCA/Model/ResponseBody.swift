//
//  ResponseBody.swift
//  WeatherAppTCA
//
//  Created by Mykhaylo Levchuk on 06/02/2023.
//

import Foundation

struct ResponseBody: Codable, Equatable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
    
    var citiRowData: CityRowData {
        let time = "\(Date(timeIntervalSince1970: Double(dt)).formatted(.dateTime.hour().minute()))"
        return .init(name: name, time: time, description: weather[0].main, temp: Int(main.temp))
    }
}

// MARK: - Clouds
struct Clouds: Codable, Equatable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable, Equatable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable, Equatable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int
    
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let tempKelvin = try container.decode(Double.self, forKey: .temp)
        let feelsLikeKelvin = try container.decode(Double.self, forKey: .feelsLike)
        let tempMinKelvin = try container.decode(Double.self, forKey: .tempMin)
        let tempMaxKelvin = try container.decode(Double.self, forKey: .tempMax)
        
        temp = tempKelvin - 273.15
        feelsLike = feelsLikeKelvin - 273.15
        tempMin = tempMinKelvin - 273.15
        tempMax = tempMaxKelvin - 273.15
        pressure = try container.decode(Int.self, forKey: .pressure)
        humidity = try container.decode(Int.self, forKey: .humidity)
    }
}

// MARK: - Sys
struct Sys: Codable, Equatable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable, Equatable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
struct Wind: Codable, Equatable {
    let speed: Double
    let deg: Int
}
