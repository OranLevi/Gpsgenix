//
//  FindLocationViewController.swift
//  Gpsgenix
//
//  Created by Oran Levi on 03/12/2022.
//

import UIKit

class FindLocationViewController: UIViewController {

    @IBOutlet weak var placeNameView: UIView!
    @IBOutlet weak var coordinatesView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeNameView.isHidden = true
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func segmentController(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            placeNameView.isHidden = true
            coordinatesView.isHidden = false
        } else if sender.selectedSegmentIndex == 1 {
            placeNameView.isHidden = false
            coordinatesView.isHidden = true
        }
        
    }
}
