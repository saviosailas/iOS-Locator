//
//  LocatorViewModel.swift
//  Locator
//
//  Created by savio sailas
//

import SwiftUI
import Contacts
import CoreLocation

class LocatorViewModel: ObservableObject {
    @Published var street: String = "1 Infinite Loop"
    @Published var city: String = "Cupernito"
    @Published var state: String = "CA"
    @Published var postalCode: String = "95014"
    @Published var country: String = "US"
    @Published var isoCountryCode: String = "US"
    
    @Published var lat: String = "0.0"
    @Published var long: String = "0.0"
    
    @Published var errorMsg: String = ""
    @Published var isLoading: Bool = false
    
    func calcCoordinates() {
        configurePreSearch()
        let mailingAddress = CNMutablePostalAddress()
        mailingAddress.street = street
        mailingAddress.city = city
        mailingAddress.state = state
        mailingAddress.postalCode = postalCode
        mailingAddress.country = country
        mailingAddress.isoCountryCode = isoCountryCode
        
        let geoCorder = CLGeocoder()
        geoCorder.geocodePostalAddress(mailingAddress, preferredLocale: Locale.current) { [weak self] (placemarks, error) in
            self?.isLoading = false
            
            if let error = error {
                self?.errorMsg = "Error - \(error.localizedDescription)"
                return
            }
            
            guard let placemark = placemarks?.first, let location = placemark.location else {
                self?.errorMsg = "Unable to find coordinates"
                return
            }
            
            self?.lat = "\(location.coordinate.latitude)"
            self?.long = "\(location.coordinate.longitude)"
        }
    }
    
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private func configurePreSearch() {
        dismissKeyboard()
        lat = "0.0"
        long = "0.0"
        errorMsg = ""
        isLoading = true
    }
}
