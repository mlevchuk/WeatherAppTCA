//
//  ModelData.swift
//  WeatherAppTCA
//
//  Created by Mykhaylo Levchuk on 06/02/2023.
//

import Foundation

var previewWeather: ResponseBody = load("weatherData.json")
var previewCities: [Compact] = [
    .init(
        name: "London",
        time: "12:30",
        description: "Sunny",
        temp: 23),

    .init(
        name: "Paris",
        time: "12:30",
        description: "Sunny",
        temp: 25),

    .init(
        name: "Rome",
        time: "12:30",
        description: "Sunny",
        temp: 28),
    .init(
        name: "Madrid",
        time: "12:30",
        description: "Sunny",
        temp: 30),
    .init(
        name: "Bremen",
        time: "12:30",
        description: "Sunny",
        temp: 18)    
]

func load<T: Decodable>(_ fileName: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError("Couldn't find \(fileName) in main bundle")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(fileName) from main bundle:\n\(error)")
    }
    
    do {
        let model = try JSONDecoder().decode(T.self, from: data)
        return model
    } catch {
        fatalError("Couldn't parse \(fileName) as \(T.self): \n\(error)")
    }
}
