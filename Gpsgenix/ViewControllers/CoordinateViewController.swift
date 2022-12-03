//
//  CoordinateViewController.swift
//  Gpsgenix
//
//  Created by Oran Levi on 03/12/2022.
//

import UIKit
import CoreLocation
import MapKit

class CoordinateViewController: UIViewController,CLLocationManagerDelegate {
    
    // Scroll View
    @IBOutlet weak var scrollView: UIScrollView!
    
    // TextFields
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var localityTextField: UITextField!
    @IBOutlet weak var missionDistrictTextField: UITextField!
    @IBOutlet weak var streetNameTextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    @IBOutlet weak var subThoroughfareTextField: UITextField!
    @IBOutlet weak var oceanTextField: UITextField!
    @IBOutlet weak var countryCodeTextField: UITextField!
    
    // Views
    @IBOutlet weak var coordinatesView: UIView!
    @IBOutlet weak var resultView: UIView!
    
    var service = Service.shard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(view: coordinatesView, borderWidth: 0.1, shadowRadius: 2.0)
        setupView(view: resultView, borderWidth: 0.1, shadowRadius: 2.0)
        scrollView.showsVerticalScrollIndicator = false
    }
    
    @IBAction func findButton(_ sender: Any) {
        
        let inputLatitude = Double(latitudeTextField.text!)
        let inputLongitude = Double(longitudeTextField.text!)
        
        guard inputLatitude != nil else {
            showAlert(vc: self, message: "Invalid entry Latitude. Try again.", buttonTitle: "Ok", openSetting: false, openLocation: false, cancelButton: false)
            return
        }
        guard inputLongitude != nil else {
            showAlert(vc: self, message: "Invalid entry Longitude. Try again.", buttonTitle: "Ok", openSetting: false, openLocation: false, cancelButton: false)
            return
        }
        getAddressFromLatLon(latitude: inputLatitude!, longitude: inputLongitude!)
    }
    
    func getAddressFromLatLon(latitude: Double, longitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let latitude: Double = Double("\(latitude)")!
        let longitude: Double = Double("\(longitude)")!
        let Geocoder: CLGeocoder = CLGeocoder()
        center.latitude = latitude
        center.longitude = longitude
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        Geocoder.reverseGeocodeLocation(loc, completionHandler:
                                            {(placemarks, error) in
            if (error != nil) {
                print("reverse geodcode fail: \(error!.localizedDescription)")
                self.showAlert(vc: self, message: "Get Coordinates Failed!", buttonTitle: "Ok", openSetting: false, openLocation: false, cancelButton: false)
                return
            }
            let pm = placemarks! as [CLPlacemark]
            
            if pm.count > 0 {
                let pm = placemarks![0]
                self.countryTextField.text = pm.country ?? "N/A"
                self.localityTextField.text = pm.locality ?? "N/A"
                self.missionDistrictTextField.text = pm.subLocality ?? "N/A"
                self.streetNameTextField.text = pm.thoroughfare ?? "N/A"
                self.postalCodeTextField.text = pm.postalCode ?? "N/A"
                self.oceanTextField.text = pm.ocean ?? "N/A"
                self.countryCodeTextField.text = pm.isoCountryCode ?? "N/A"
                
                var addressString : String = ""
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                print(addressString)
            }
        })
    }
}
