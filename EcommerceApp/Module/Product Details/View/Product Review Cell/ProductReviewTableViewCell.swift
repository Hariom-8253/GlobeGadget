//
//  ProductReviewTableViewCell.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 26/07/25.
//

import UIKit

class ProductReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgVieww: UIImageView!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var lblReviewPoint: UILabel!
    @IBOutlet weak var lblTimestemp: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackStar: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgVieww.layer.cornerRadius = imgVieww.frame.size.width / 2
        imgVieww.clipsToBounds = true
        imgVieww.layer.borderWidth = 1
        imgVieww.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configreviewcell(reviewmodel: ReviewModel) {
        lblName.text = reviewmodel.name
        lblComments.text = reviewmodel.comments
        lblReviewPoint.text = "\(reviewmodel.reviewpoint)"
        imgVieww.image = UIImage(named: reviewmodel.imageName)
        lblTimestemp.text = "\(reviewmodel.timestamp.timeAgoDisplay())"
        fillStars(for: reviewmodel.reviewpoint, in: stackStar)
        
    }
    
    func fillStars(for rating: Int, in stackView: UIStackView) {
        for (index, view) in stackView.arrangedSubviews.enumerated() {
            if let imageView = view as? UIImageView {
                if index < rating {
                    imageView.image = UIImage(systemName: "star.fill") // Filled star
                    imageView.tintColor = .systemYellow
                } else {
                    imageView.image = UIImage(systemName: "star") // Empty star
                    imageView.tintColor = .systemGray
                }
            }
        }
    }
    
}
