//
//  CityRow.swift
//  WeatherAppTCA
//
//  Created by Mykhaylo Levchuk on 07/02/2023.
//

import SwiftUI

struct CityRow: View {
    var data: CityRowData
    
    var body: some View {
        HStack {
            VStack {
                Text(data.name)
                    .bold()
                    .font(.title)
                Text(data.time)
                    .font(.caption)
                Spacer(minLength: 15)
                Text(data.description)
                
            }
            .padding()
            Spacer()
            Text("\(data.temp) °")
                .font(.system(size: 50))
        }
        .frame(maxWidth: .infinity, maxHeight: 80)
        .padding()
        .background(Constants.Colors.highlight)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

struct CityRow_Previews: PreviewProvider {
    static var previews: some View {
        CityRow(data: .init(
            name: "London",
            time: "12:30",
            description: "Sunny",
            temp: 23)
        )
    }
}
