//
//  SettingPageTableViewCell.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 11/07/25.
//

import UIKit

class SettingPageTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var switchNotification: UISwitch!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblSetting: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell (product : ClassSettingOption){
        lblSetting.text = product.strTitle
        imgIcon.image = UIImage(systemName: product.strImage)
        switchNotification.isHidden = product.intTag != 7
    }
    
    @IBAction func switchOnOff(_ sender: Any) {
        print(switchNotification.isOn ? "On" : "Off")
    }
}
