//
//  AddressTableViewCell.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 18/07/25.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lblPincode: UILabel!
    @IBOutlet weak var lblAdd2: UILabel!
    @IBOutlet weak var lblAdd1: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblMObileNO: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var lblFirstName: UILabel!
    
    var btnEditClick : (() -> Void) = {}
    var btnDeleteClick : (() -> Void) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btnDeleteAction(_ sender: Any) {
        btnDeleteClick()
    }
    
    @IBAction func btnEditAction(_ sender: Any) {
        btnEditClick()
    }

}
