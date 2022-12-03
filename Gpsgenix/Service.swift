//
//  Service.swift
//  Gpsgenix
//
//  Created by Oran Levi on 02/12/2022.
//

import UIKit


class Service {
    
    static let shard = Service()
    
    func showAlert(vc: UIViewController, message: String, openLocation: Bool){
            let alertController = UIAlertController (title: "Alert", message: message, preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                
                if (openLocation) {
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                } else {
                    UIApplication.shared.open(URL(string: "App-prefs:LOCATION_SERVICES")!)
                    
                }
            }
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            
            vc.present(alertController, animated: true, completion: nil)
        }
    
}

