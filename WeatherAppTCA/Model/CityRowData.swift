//
//  CityRowData.swift
//  WeatherAppTCA
//
//  Created by Mykhaylo Levchuk on 07/02/2023.
//

import Foundation

struct CityRowData: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let time: String
    let description: String
    let temp: Int
}
