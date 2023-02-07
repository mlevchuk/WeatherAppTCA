//
//  CitiesView.swift
//  WeatherAppTCA
//
//  Created by Mykhaylo Levchuk on 07/02/2023.
//

import SwiftUI

struct CitiesView: View {
    @State var cities: [CityRowData] = []
    @State private var searchText = ""
    var weatherManager = WeatherManager()
    
    var body: some View {
        NavigationView {
            CitiesList(cities: $cities)
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .onSubmit(of: .search) {
                    Task {
                        do {
                            try await fetchCity()
                        } catch {
                            print(error)
                        }
                    }
                }
                .foregroundColor(.white)
                .navigationBarTitleDisplayMode(.inline)
                .background(Constants.Colors.primary)
                .navigationBarColor(backgroundColor: Constants.Colors.primary.uiColor(), titleColor: .white)
            
        }.accentColor(.white)
    }
    
    private func fetchCity() async throws {
        let responseBody = try await weatherManager.getCurrentWeather(searchText)
        cities.append(responseBody.citiRowData)
    }
}

struct CitiesList: View {
    @Binding var cities: [CityRowData]
    var body: some View {
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
        }
    }
}

struct CitiesView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesView(cities: previewCities)
    }
}
