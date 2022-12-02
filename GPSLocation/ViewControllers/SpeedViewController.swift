//
//  SpeedViewController.swift
//  GPSLocation
//
//  Created by Oran Levi on 02/12/2022.
//

import UIKit
import CoreLocation

class SpeedViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var speedTableView: UITableView!
    
    let locationManager = CLLocationManager()
    
    var mphSpeed: String = "---"
    var kmhSpeed: String = "---"
    var cmsSpeed: String = "---"
    var mmsSpeed: String = "---"
    var ftsSpeed: String = "---"
    var mhSpeed: String = "---"
    var fthSpeed: String = "---"
    var mminSpeed: String = "---"
    var ftminSpeed: String = "---"
    var ktSpeed: String = "---"
    var machSpeed: String = "---"

    override func viewDidLoad() {
        super.viewDidLoad()
        speedTableView.dataSource = self
        getSpeed()
        setupView()
    }
    
    func setupView() {
      
    }
    
    func getSpeed() {
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Get Current Location
        let location = locations.last! as CLLocation
        let _ :CLLocation = locations[0] as CLLocation
        
        // For getting speed
        // 1 mile = 5280 feet
        // Meter to miles = m * 0.00062137
        // 1 meter = 3.28084 feet
        // 1 foot = 0.3048 meters
        // km = m / 1000
        // m = km * 1000
        // ft = m / 3.28084
        // 1 mile = 1609 meters
        
        let mph = location.speed * 2.23694
        let kmh = location.speed * 3.6
        let cms = location.speed * 100 // 1 meter per second is 100 centimeters per second.
        let mms = location.speed * 1000 // 1 meter per second is 1000 milimeters per second.
        let fts = location.speed * 3.28084 // 1 meter per second is 3.28084 feet per second.
        let mh = location.speed * 3600 // 1 meter per second is 3600 meters per hour.
        let fth = location.speed * 11811.02364 // 1 meter per second is 11811.02364 feet per hour.
        let mmin = location.speed * 60 //1 meter per second is 60 meters per minute.
        let knots = location.speed * 1.94384 //1 meter per second is 1.94384 knots.
        let mach = location.speed * 0.003018 //1 meter per second is 0.003018 Maches.


        mphSpeed = (location.speed<0) ? "--" : String(format: "%d", Int(mph))
        kmhSpeed = (location.speed<0) ? "--" : String(format: "%d", Int(kmh))
        cmsSpeed = (location.speed<0) ? "--" : String(format: "%d", Int(cms))
        mmsSpeed = (location.speed<0) ? "--" : String(format: "%d", Int(mms))
        ftsSpeed = (location.speed<0) ? "--" : String(format: "%d", Int(fts))
        mhSpeed = (location.speed<0) ? "--" : String(format: "%d", Int(mh))
        fthSpeed = (location.speed<0) ? "--" : String(format: "%d", Int(fth))
        mminSpeed = (location.speed<0) ? "--" : String(format: "%d", Int(mmin))
        ktSpeed = (location.speed<0) ? "--" : String(format: "%d", Int(knots))
        machSpeed = (location.speed<0) ? "--" : String(format: "%d", Int(mach))

        locationManager.startUpdatingHeading()
        speedTableView.reloadData()
    }
    
}

extension SpeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpeedTableViewCell", for: indexPath) as! SpeedTableViewCell
        
        if indexPath.row == 0 {
            cell.speedLabel.text = "MPH (Mile per hour): "
            cell.speedLABL.text = String(mphSpeed)
        } else if indexPath.row == 1 {
            cell.speedLabel.text = "KMH (Kilometre per hour): "
            cell.speedLABL.text = String(kmhSpeed)
        } else if indexPath.row == 2 {
            cell.speedLabel.text = "cm/s (Centimeters per second): "
            cell.speedLABL.text = String(cmsSpeed)
        } else if indexPath.row == 3 {
            cell.speedLabel.text = "mm/s (Milimeters per second): "
            cell.speedLABL.text = String(mmsSpeed)
        } else if indexPath.row == 4 {
            cell.speedLabel.text = "Ft/s (Feet per second): "
            cell.speedLABL.text = String(ftsSpeed)
        } else if indexPath.row == 5 {
            cell.speedLabel.text = "M/h (Meters per hour)"
            cell.speedLABL.text = String(mhSpeed)
        } else if indexPath.row == 6 {
            cell.speedLabel.text = "Ft/h (Feet per hour)"
            cell.speedLABL.text = String(fthSpeed)
        } else if indexPath.row == 7 {
            cell.speedLabel.text = "M/min (Meters per minute)"
            cell.speedLABL.text = String(mminSpeed)
        } else if indexPath.row == 8 {
            cell.speedLabel.text = "Kt (knots)"
            cell.speedLABL.text = String(ktSpeed)
        } else if indexPath.row == 9 {
            cell.speedLabel.text = "Maches (Maches)"
            cell.speedLABL.text = String(machSpeed)
        }
        return cell
    }
}
