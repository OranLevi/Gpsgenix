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
    
    //Buttons
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var openMapButton: UIButton!

    // Text Filed
    @IBOutlet weak var planceNameText: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    
    // Views
    @IBOutlet weak var placeNameView: UIView!
    @IBOutlet weak var resultView: UIView!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @IBAction func findButton(_ sender: Any) {
        getCoordinates(address: planceNameText.text ?? "")
    }
    
    func setupViews() {
        scrollView.showsVerticalScrollIndicator = false
        setupView(view: placeNameView, borderWidth: 0.1, shadowRadius: 2.0)
        setupView(view: resultView, borderWidth: 0.1, shadowRadius: 2.0)
        copyButton.layer.cornerRadius = 5
        findButton.layer.cornerRadius = 5
        openMapButton.layer.cornerRadius = 5
    }
    
    func getCoordinates(address: String) {
        getCoordinateFrom(address: address) { coordinate, error in
            
            self.getCoordinateFrom(address: address) { coordinate, error in
                guard let coordinate = coordinate, error == nil else {
                    self.showAlert(vc: self, message: "Not found place with this coordinate", buttonTitle: "OK", cancelButton: false, action: {
                        self.latitudeTextField.text = nil
                        self.longitudeTextField.text = nil
                        print("## Not found place with this coordinate")
                    })
                    return
                }
                DispatchQueue.main.async {
                    print(address, "Location:", coordinate)
                    print(coordinate.latitude)
                    print(coordinate.longitude)
                    self.latitudeTextField.text = String(coordinate.latitude)
                    self.longitudeTextField.text = String(coordinate.longitude)
                }
                
            }
        }
    }
    
    @IBAction func copyButton(_ sender: Any) {
        if latitudeTextField.text == "" || longitudeTextField.text == "" {
            copyButton.setTitle("Latitude and Longitude is empty", for: .normal)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.copyButton.setTitle("Copy", for: .normal)
                self.copyButton.setImage(UIImage(), for: .normal)
            }
            return
        }
        
        let pasteboard = UIPasteboard.general
        pasteboard.string = "\(latitudeTextField.text ?? ""), \(longitudeTextField.text ?? "")"
        copyButton.setTitle("Copied", for: .normal)
        copyButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.copyButton.setTitle("Copy", for: .normal)
            self.copyButton.setImage(UIImage(), for: .normal)
        }
    }
    
    @IBAction func openMapButton(_ sender: Any) {
        if latitudeTextField.text == "" || longitudeTextField.text == "" {
            showAlert(vc: self, message: "Please enter place Name", buttonTitle: "OK", cancelButton: false, action: {
                print("## Please enter place Name")
            })
            return
        } else {
            let url = "http://maps.apple.com/maps?ll=\(latitudeTextField.text!),\(longitudeTextField.text!)"
            print(url)
            UIApplication.shared.open(URL(string: "\(url)")!)

        }
    }
    
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
}
