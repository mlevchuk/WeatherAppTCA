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
        var cities: [ResponseBody] = []
        var alert: AlertState<Action>?
    }
    
    enum Action: Equatable {
        case textSubmitted(query: String)
        case cityResponse(TaskResult<ResponseBody>)
        case alertDismissed
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
            case .textSubmitted(let query):
                return .task {
                    await .cityResponse(TaskResult { try await manager.getCurrentWeather(query) })
                }
            case .cityResponse(.success(let responseBody)):
                state.cities.append(responseBody)
                return .none
            case .cityResponse(.failure):
                state.alert = AlertState<CitiesViewReducer.Action>.init(
                    title: { TextState("Alert") },
                    actions: {
                        ButtonState(label: { TextState("OK") })
                    }, message: nil)
                return .none
            case .alertDismissed:
                state.alert = nil
                return .none
        }
    }
}
