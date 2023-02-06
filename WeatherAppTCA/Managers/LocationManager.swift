//
//  LocationManager.swift
//  WeatherAppTCA
//
//  Created by Mykhaylo Levchuk on 03/02/2023.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private var authorizationStatus: CLAuthorizationStatus { locationManager.authorizationStatus }
    
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        isLoading = true
        locationManager.requestLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: ", error)
        isLoading = false
    }
}
