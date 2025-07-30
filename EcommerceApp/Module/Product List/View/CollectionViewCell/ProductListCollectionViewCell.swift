//
//  ProductListCollectionViewCell.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 19/07/25.
//

import UIKit

class ProductListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewCategory.layer.cornerRadius = 8
    }
    
}
