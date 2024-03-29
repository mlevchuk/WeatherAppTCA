//
//  CitiesView.swift
//  WeatherAppTCA
//
//  Created by Mykhaylo Levchuk on 07/02/2023.
//

import SwiftUI
import ComposableArchitecture

struct CitiesView: View {
    let store: StoreOf<CitiesViewReducer>
    @Environment(\.dismissSearch) private var dismissSearch
    
    var body: some View {
        NavigationView {
            WithViewStore(store, observe: { $0 }) { viewStore in
                CitiesList(cities: viewStore.cities.map { $0.compact })
                    .searchable(
                        text: viewStore.binding(get: { $0.query }, send: CitiesViewReducer.Action.textChanged),
                        placement: .navigationBarDrawer(displayMode: .always)
                    )
                    .onSubmit(of: .search) {
                        viewStore.send(.textSubmitted)
                    }
                    .foregroundColor(.white)
                    .navigationBarTitleDisplayMode(.inline)
                    .background(Constants.Colors.primary)
                    .navigationBarColor(backgroundColor: Constants.Colors.primary.uiColor(), titleColor: .white)
            }
            .alert(store.scope(state: \.alert), dismiss: .alertDismissed)
        }.accentColor(.white)
    }
}

struct CitiesList: View {
    @Environment(\.dismissSearch) var dismissSearch
    var cities: [Compact]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if cities.isEmpty {
                    Constants.Colors.primary
                } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                ForEach(cities) { cityData in
                                    NavigationLink(
                                        destination: {
                                            WeatherView(city: cityData.name)
                                        }, label: {
                                            CityRow(data: cityData)
                                        })
                                }
                                .padding([.leading, .trailing, .top], 8)
                            }
                        }
                        .frame(maxHeight: .infinity)
                }
            }
            .onTapGesture { dismissSearch() }
        }
    }
}

struct CitiesView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesView(store: .init(initialState: CitiesViewReducer.State(), reducer: CitiesViewReducer()))
    }
}
