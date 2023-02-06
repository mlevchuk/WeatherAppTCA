//
//  WeatherRow.swift
//  WeatherAppTCA
//
//  Created by Mykhaylo Levchuk on 06/02/2023.
//

import SwiftUI

struct WeatherRow: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: logo)
                .font(.title2)
                .frame(width: 40, height: 40)
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.888))
                .cornerRadius(50)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.caption)
                Text(value)
                    .bold()
                    .font(.title)
            }
        }
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(logo: "thermometer", name: "Feels like", value: "8°")
    }
}
