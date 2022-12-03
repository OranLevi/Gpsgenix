//
//  SpeedCommonTableViewCell.swift
//  GPSLocation
//
//  Created by Oran Levi on 02/12/2022.
//

import UIKit

class SpeedCommonTableViewCell: UITableViewCell {

    @IBOutlet weak var kmhLabel: UILabel!
    @IBOutlet weak var mphLabel: UILabel!
    @IBOutlet weak var mphView: UIView!
    @IBOutlet weak var kmhView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView() {
        kmhView.layer.cornerRadius = 10
        kmhView.layer.borderWidth = 0.2
        kmhView.layer.shadowColor = UIColor.black.cgColor
        kmhView.layer.shadowOffset = CGSize(width: 0, height: 0)
        kmhView.layer.shadowRadius = 3.0
        kmhView.layer.shadowOpacity = 0.5
        kmhView.layer.masksToBounds = false
        
        mphView.layer.cornerRadius = 10
        mphView.layer.borderWidth = 0.2
        mphView.layer.shadowColor = UIColor.black.cgColor
        mphView.layer.shadowOffset = CGSize(width: 0, height: 0)
        mphView.layer.shadowRadius = 3.0
        mphView.layer.shadowOpacity = 0.5
        mphView.layer.masksToBounds = false
    }

}
