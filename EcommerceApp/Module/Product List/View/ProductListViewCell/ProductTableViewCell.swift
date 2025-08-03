//
//  ProductTableViewCell.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 09/07/25.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var btnCartDelete: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var btnAddtoCart: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    
    var btnDeleteWishlistClick : (() -> Void) = {}
    var onAddToCart : (() -> Void)?
    var ShowAlert : (()->Void)?
    var onUpdate : (()->Void)?
    var btnDeleteCartClick : (() -> Void) = {}
    var objProduct: ProductModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnLike.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        btnAddtoCart.layer.cornerRadius = 8
    }
    
    @IBAction func btnLikeClick(_ sender: UIButton) {
        objProduct?.addFavouriteProduct = !(objProduct?.addFavouriteProduct ?? false)
        self.setImage()
        
        if let index = app.wishlistArray.firstIndex(where: {$0.productId == objProduct?.productId}){
            app.wishlistArray.remove(at: index)
        }
        else{
            app.wishlistArray.append(objProduct!)
        }
        
        btnDeleteWishlistClick()
        
    }
    
    func setImage() {
        let imageName =  objProduct?.addFavouriteProduct ?? false ? "heart.fill" : "heart"
        btnLike.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func configureCell (product : ProductModel){
        self.lblTitle.text = product.strTitle
        self.lblCategory.text = product.strCategory
        self.lblPrice.text = "\(product.doublePrice)"
        self.lblDescription.text = product.strDescription
        self.imgView.image = UIImage(named: product.strImageName)
        self.lblQty.text = "Qty: \(product.intProductQty ?? 1)"
        self.setImage()
        self.stepper.value = Double(product.intProductQty ?? 1)
        self.objProduct = product
        
    }
    
    
    func configureCellCart (product : ProductModel){
        
        self.lblTitle.text = product.strTitle
        self.lblCategory.text = product.strCategory
        self.lblPrice.text = "\(product.doublePrice)"
        self.lblDescription.text = product.strDescription
        self.imgView.image = UIImage(named: product.strImageName)
        self.setImage()
        self.btnAddtoCart.isHidden = true
        self.lblQty.text = "Qty: \(product.intProductQty ?? 1)"
        lblDescription.isHidden = true
        btnLike.isHidden = true
        stepper.maximumValue = 1000000
        self.stepper.value = Double(product.intProductQty ?? 1)
        btnAddtoCart.isHidden = true
        
        self.objProduct = product
        
    }
    
    @IBAction func stepperValueChange(_ sender: Any) {
        objProduct?.intProductQty = Int(stepper.value)
        lblQty.text = "Qty : \(objProduct?.intProductQty ?? 1)"
        onAddToCart?()
    }
    
    
    @IBAction func btnDeleteProductInCart(_ sender: Any) {
        btnDeleteCartClick()
        
    }
    @IBAction func btnAddToCartClick(_ sender: Any) {
        
        if let obj = objProduct {
            checkProduct(objProductToAdd: obj)
        }
        ShowAlert?()
        onUpdate?()
    }
}

func checkProduct(objProductToAdd : ProductModel){
    var isItemAlreadyAdded : Bool = false
    for item in app.arrCart{
        if item.strTitle == objProductToAdd.strTitle{
            item.intProductQty = (item.intProductQty ?? 1) + (objProductToAdd.intProductQty ?? 1)
            isItemAlreadyAdded = true
        }
    }
    
    if !isItemAlreadyAdded{
        let objProduct = ProductModel(strTitle: objProductToAdd.strTitle, doublePrice: objProductToAdd.doublePrice, strCategory: objProductToAdd.strCategory, strDescription: objProductToAdd.strDescription, strImageName: objProductToAdd.strImageName, strDescription2: objProductToAdd.strDescription2, arrImage: objProductToAdd.arrImage)
        objProduct.intProductQty = objProductToAdd.intProductQty
        app.arrCart.append(objProduct)
    }
}
