//
//  LocationManager.swift
//  Weatherly
//
//  Created by Noam Efergan on 03/05/2021.
//

import CoreLocation
import Foundation

final class LocationManager: NSObject, CLLocationManagerDelegate {

    //Shared instance
    static let shared = LocationManager()

    // MARK: - Public Variables

    public var didUserAllow = false
    public var didAllowLocation: ((Bool) -> Void)?

    // MARK: - Private variables

    private let lm = CLLocationManager()

    // MARK: - Init method

    private override init() {
        super.init()
        lm.delegate = self
    }

    // MARK: - Public helper methods

    /// Request location permission from the user
    public func askForAuth() {
        lm.requestWhenInUseAuthorization()
    }

    /// Gets the name of the city the user is in
    func getLocation(completion: @escaping (_ city: String?, _ error: String?) -> ()) {
        guard let location = lm.location ,
              didUserAllow else {
            completion(nil,Constants.errorSomethingWentWrong)
            return
        }
        CLGeocoder().reverseGeocodeLocation(location) { locations, error in
            if error != nil {
                completion(nil, error!.localizedDescription)
            }
            completion(locations?.first?.locality, nil)
        }
    }

    /// Getting notified when a user changes their location preferences
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        //User did not approve location
        case .notDetermined, .restricted, .denied:
            didAllowLocation?(false)
            self.didUserAllow = false
        // User approved location service, start updating and inform the view model
        case .authorizedAlways , .authorizedWhenInUse:
            lm.startUpdatingLocation()
            self.didUserAllow = true
            didAllowLocation?(true)
        @unknown default:
            fatalError()
        }
    }
    // MARK: - Private helper methods

    /// Checks if the user has already authorised the location services
    private func checkAuth() {
        switch lm.authorizationStatus {
        case .notDetermined, .restricted, .denied:
            self.didUserAllow = false
        case .authorizedAlways, .authorizedWhenInUse:
            self.didUserAllow = true
        @unknown default:
            fatalError()
        }
    }

}
