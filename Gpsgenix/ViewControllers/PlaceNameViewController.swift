//
//  PlaceNameViewController.swift
//  Gpsgenix
//
//  Created by Oran Levi on 03/12/2022.
//

import UIKit
import CoreLocation
import MapKit

class PlaceNameViewController: UIViewController,CLLocationManagerDelegate {
    
    // Scroll View
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Text Filed
    @IBOutlet weak var planceNameText: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    
    // Views
    @IBOutlet weak var placeNameView: UIView!
    @IBOutlet weak var resultView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(view: placeNameView, borderWidth: 0.1, shadowRadius: 2.0)
        setupView(view: resultView, borderWidth: 0.1, shadowRadius: 2.0)
        scrollView.showsVerticalScrollIndicator = false
    }
    
    @IBAction func findButton(_ sender: Any) {
        getCoordinates(address: planceNameText.text ?? "")
    }
    
    func getCoordinates(address: String) {
        getCoordinateFrom(address: address) { coordinate, error in
            
            self.getCoordinateFrom(address: address) { coordinate, error in
                guard let coordinate = coordinate, error == nil else { return }
                DispatchQueue.main.async {
                    print(address, "Location:", coordinate)
                    self.latitudeTextField.text = String(coordinate.latitude)
                    self.longitudeTextField.text = String(coordinate.longitude)
                }
                
            }
        }
    }
    
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
}
