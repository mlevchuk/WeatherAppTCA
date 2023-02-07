//
//  CitiesReducer.swift
//  WeatherAppTCA
//
//  Created by Mykhaylo Levchuk on 07/02/2023.
//

import Foundation
import ComposableArchitecture

struct CitiesViewReducer: ReducerProtocol {
    var manager: WeatherManager = .init()
    
    struct State: Equatable {
        var query: String = ""
        var cities: [ResponseBody] = []
        var alert: AlertState<Action>?
    }
    
    enum Action: Equatable {
        case textChanged(query: String)
        case textSubmitted
        case cityResponse(TaskResult<ResponseBody>)
        case alertDismissed
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
            case .textChanged(let query):
                state.query = query
                return .none
            case .textSubmitted:
                let item = state.query
                state.query = ""
                return .task {
                    await .cityResponse(TaskResult { try await manager.getCurrentWeather(item) })
                }
            case .cityResponse(.success(let responseBody)):
                state.cities.append(responseBody)
                return .none
            case .cityResponse(.failure):
                state.alert = AlertState<CitiesViewReducer.Action>.init(
                    title: { TextState("") },
                    actions: {
                        ButtonState(label: { TextState("OK") })
                    },
                    message: { TextState("Failed to fetch city with provided name") }
                )
                return .none
            case .alertDismissed:
                state.alert = nil
                return .none
        }
    }
}
