//
//  ErrorView.swift
//  WeatherAppTCA
//
//  Created by Mykhaylo Levchuk on 07/02/2023.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack {
            MessagesView()
            Button(
                action: {},
                label: { Text("Send report").bold() }
            )
            .frame(width: 100, height: 45, alignment: .center)
            .padding([.leading, .trailing], 15)
            .background(Constants.Colors.highlight)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .background(Constants.Colors.primary)
        .foregroundColor(.white)
    }
}

fileprivate struct MessagesView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Oops! Something went wrong!")
                .bold()
                .font(.title)
                .multilineTextAlignment(.leading)
            Text("Help us improve your experience by sending an error report")
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
