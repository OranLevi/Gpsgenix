//
//  ViewController.swift
//  Gpsgenix
//
//  Created by Oran Levi on 02/12/2022.
//

import UIKit
import MapKit
import CoreLocation

class MyLocationViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {
    
    // Views
    @IBOutlet weak var longitudeView: UIView!
    @IBOutlet weak var latitudeView: UIView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var gpsStatsView: UIView!
    @IBOutlet weak var altitudeView: UIView!
    @IBOutlet weak var signalView: UIView!

    // Map
    @IBOutlet weak var mapView: MKMapView!
    
    // Labels
    @IBOutlet weak var gpsStatusLabel: UILabel!
    @IBOutlet weak var localityLabel: UILabel!
    @IBOutlet weak var administrativeAreaLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var signalLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var service = Service.shard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(view: longitudeView, borderWidth: 0.1, shadowRadius: 2.0)
        setupView(view: latitudeView, borderWidth: 0.1, shadowRadius: 2.0)
        setupView(view: locationView, borderWidth: 0.1, shadowRadius: 2.0)
        setupView(view: gpsStatsView, borderWidth: 0.1, shadowRadius: 2.0)
        setupView(view: altitudeView, borderWidth: 0.1, shadowRadius: 2.0)
        setupView(view: signalView, borderWidth: 0.1, shadowRadius: 2.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getLocation()
        statusGps()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - Get Locations
    func getLocation() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.startUpdatingLocation()
            }
        }
    }

    // MARK: - Get Status GPS
    func statusGps() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                switch self.locationManager.authorizationStatus {
                case .notDetermined:
                    print("## No access GPS")
                    DispatchQueue.main.async {
                        self.gpsStatusLabel.text = "NO"
                        self.gpsStatusLabel.textColor = UIColor.systemRed
                    }
                case .restricted :
                    print("## restricted GPS")
                case .denied:
                    print("## denied GPS")
                    DispatchQueue.main.async {
                        self.showAlert(vc: self, message: "You must give permission to the Location", buttonTitle: "Setting", cancelButton: true, action: {
                            UIApplication.shared.open(URL(string: "App-prefs:LOCATION_SERVICES")!)
                        })
                        self.gpsStatusLabel.text = "NO"
                        self.gpsStatusLabel.textColor = UIColor.systemRed
                    }
                case .authorizedAlways, .authorizedWhenInUse:
                    print("## Access GPS")
                    DispatchQueue.main.async {
                        self.gpsStatusLabel.text = "YES"
                        self.gpsStatusLabel.textColor = UIColor.systemGreen
                    }
                @unknown default:
                    break
                }
            } else {
                print("## Location services are not enabled")
                DispatchQueue.main.async {
                    self.showAlert(vc: self, message: "Location services are not enabled", buttonTitle: "Setting", cancelButton: false, action: {
                        UIApplication.shared.open(URL(string: "App-prefs:LOCATION_SERVICES")!)
                    })
                }
            }
        }
    }
    
// MARK: - LocationManager Update Locations
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        statusGps()
        
        let userLocation :CLLocation = locations[0] as CLLocation
        let locValue: CLLocationCoordinate2D = manager.location!.coordinate
        
        // Check Signal
        if (userLocation.horizontalAccuracy < 0) {
          print("NO SIGNAL")
            signalLabel.text = "NO SIGNAL"
            signalLabel.textColor = UIColor.systemRed
       }
       else if (userLocation.horizontalAccuracy > 163) {
           print("Poor Signal")
           signalLabel.text = "Poor Signal"
           signalLabel.textColor = UIColor.systemYellow
       }
       else if (userLocation.horizontalAccuracy > 48) {
           print("Average Signal")
           signalLabel.text = "Average Signal"
           signalLabel.textColor = UIColor.systemOrange
       }
       else {
           print("Full Signal")
           signalLabel.text = "Full Signal"
           signalLabel.textColor = UIColor.systemGreen
       }
        
        // Get Latitude and Longitude
        print("user latitude = \(locValue.latitude)")
        print("user longitude = \(locValue.longitude)")
        latitudeLabel.text = String(locValue.latitude)
        longitudeLabel.text = String(locValue.longitude)
        altitudeLabel.text = String(userLocation.altitude)
        
        
        // Get locality and administrativeArea and country
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(userLocation) { (placeMarks, error) in
            if (error != nil){
                print("error Geocode")
            }
            let placeMark = placeMarks
            if placeMark?.count ?? 0 > 0 {
                let placeMark = placeMarks![0]
                print("\(placeMark.locality ?? "## locality N/A")")
                print("\(placeMark.administrativeArea ?? "## administrativeArea N/A")")
                print("\(placeMark.country ?? "## countryN/A")")
             
                self.localityLabel.text = placeMark.locality ?? "N/A"
                self.administrativeAreaLabel.text = placeMark.administrativeArea ?? "N/A"
                self.countryLabel.text = placeMark.country ?? "N/A"
                
            }
        }
        
        mapView.mapType = MKMapType.satelliteFlyover
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "current Location"
        mapView.addAnnotation(annotation)
    }
}
