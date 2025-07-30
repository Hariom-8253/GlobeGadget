//
//  ProductDetailViewController.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 15/07/25.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var productSegment: UISegmentedControl!
    @IBOutlet weak var tblReview: UITableView!
    @IBOutlet weak var colViewProductDetails: UICollectionView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lblLargeDescription: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var btnAddTOCart: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var arrImg : [String] = []
    var objProduct: ProductModel?
    var arrReview = ReviewModel.generateDummyReviews()
    var productNavTitle : String?
    var imgProduct : UIImage?
    var strrCategory : String?
    var intPrice : String?
    var strrDescription : String?
    var productImg2 : String?
    var strName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productSegment.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
        tblReview.register(UINib(nibName: "ProductReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductReviewTableViewCell")
        
        colViewProductDetails.register(UINib(nibName: "ProductDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductDetailCollectionViewCell")
        
        btnAddTOCart.layer.cornerRadius = 8
        
        contentView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.contentView.isHidden = false
        }
        
        self.lblName.text = strName
        self.title = productNavTitle
        self.lblCategory.text = strrCategory
        self.lblPrice.text = intPrice
        self.lblLargeDescription.text = strrDescription
        self.lblQty.text = "Qty : \(objProduct?.intProductQty ?? 1)"
        
        if let productImages = objProduct?.arrImage{
            arrImg = productImages
            colViewProductDetails.reloadData()
        }
        else{
            
        }
    }
    
    @IBAction func btnAddToCartDetail(_ sender: Any) {
        
        UIAlertController.showAlert(title: "Success", message: "Product added to cart ", viewController: self)
        
        if let obj = objProduct {
            checkProduct(objProductToAdd: obj)
        }
    }
    
    @IBAction func productSegmentAction(_ sender: UISegmentedControl) {
        
        activityIndicator.isHidden = true
        
        switch sender.selectedSegmentIndex {
        case 0 :
            detailView.isHidden = false
            tblReview.isHidden = true
            btnAddTOCart.isHidden = false
            
            
        case 1:
            detailView.isHidden = true
            tblReview.isHidden = false
            btnAddTOCart.isHidden = true
            
        default:
            break;
        }
        
    }
    
    @IBAction func valueStepper(_ sender: Any) {
        objProduct?.intProductQty = Int(stepper.value)
        lblQty.text = "Qty : \(objProduct?.intProductQty ?? 1)"
    }
    
}
