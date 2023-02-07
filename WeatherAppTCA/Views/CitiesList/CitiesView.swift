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
                .onSubmit(of: .search, {})
                .foregroundColor(.white)
                .navigationBarTitleDisplayMode(.inline)
                .background(Constants.Colors.primary)
                .navigationBarColor(backgroundColor: Constants.Colors.primary.uiColor(), titleColor: nil)
        }
    }
    
    private func fetchCity() async throws {
        let responseBody = try await weatherManager.getCurrentWeather(searchText)
        
    }
}

struct CitiesList: View {
    @Binding var cities: [CityRowData]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(cities) { cityData in
                    CityRow(data: cityData)
                }
                .padding([.leading, .trailing], 8)
            }
        }
    }
}

struct CitiesView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesView(cities: previewCities)
    }
}
