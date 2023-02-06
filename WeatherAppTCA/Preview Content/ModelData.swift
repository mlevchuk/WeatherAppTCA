//
//  ModelData.swift
//  WeatherAppTCA
//
//  Created by Mykhaylo Levchuk on 06/02/2023.
//

import Foundation

var previewWeather: ResponseBody = load("weatherData.json")

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
