//
//  Service.swift
//  Gpsgenix
//
//  Created by Oran Levi on 02/12/2022.
//

import UIKit

// MARK: - Service

class Service {
    static let shard = Service()
}

// MARK: - extension UIViewController
extension UIViewController {
    
    func setupView(view: UIView , borderWidth: Double , shadowRadius: Double) {
        view.layer.cornerRadius = 10
        view.layer.borderWidth = borderWidth
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
    }
    
    func showAlert(vc: UIViewController, message: String, buttonTitle: String, cancelButton: Bool, action: @escaping () -> ()){
        let alertController = UIAlertController (title: "Alert", message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: buttonTitle , style: .default) { (_) -> Void in
            action()
        }
        alertController.addAction(settingsAction)
        if cancelButton {
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
        }
        vc.present(alertController, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
