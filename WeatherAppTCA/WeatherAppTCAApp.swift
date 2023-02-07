//
//  WeatherAppTCAApp.swift
//  WeatherAppTCA
//
//  Created by Mykhaylo Levchuk on 03/02/2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct WeatherAppTCAApp: App {
    let store: StoreOf<CitiesViewReducer> = .init(initialState: CitiesViewReducer.State(), reducer: CitiesViewReducer())
    var body: some Scene {
        WindowGroup {
            CitiesView(store: store)
        }
    }
}
