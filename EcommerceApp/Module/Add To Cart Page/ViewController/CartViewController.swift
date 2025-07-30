//
//  CartViewController.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 17/07/25.
//

import UIKit

class CartViewController: UIViewController {
    
    var isValidCoupon: Bool = false
    var taxpersentage: Double = 0.075
    var totalprice: Double = 0.0
    var selectedCoupon: Coupon?
    var arrcoupan = Coupon.generateCoupons().map{$0.code}
    
    @IBOutlet weak var stackCalculation: UIStackView!
    @IBOutlet weak var stackOriginalPrice: UIStackView!
    @IBOutlet weak var stackDiscount: UIStackView!
    @IBOutlet weak var lblSGST: UILabel!
    @IBOutlet weak var lblCGST: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblOriginalPrice: UILabel!
    @IBOutlet weak var btnApplyCoupon: UIButton!
    @IBOutlet weak var txtCouponCode: UITextField!
    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var tblCart: UITableView!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var btnPlaceOrder: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if app.arrCart.count == 0{
            lblEmpty.isHidden = false
            tblCart.isHidden = true
            stackCalculation.isHidden = true
        }
        
        else{
            lblEmpty.isHidden = true
            tblCart.isHidden = false
        }
    }
    
    @objc func openCart() {
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allViews = [txtCouponCode!, btnPlaceOrder!, btnApplyCoupon!, stackCalculation!]
        
        styleViews(allViews, cornerRadius: 8, borderWidth: 1, borderColor: UIColor.colorPrimary.cgColor)
        
//        stackCalculation.layer.cornerRadius = 10
//        stackCalculation.layer.borderWidth = 2
        stackCalculation.isLayoutMarginsRelativeArrangement = true
        stackCalculation.layoutMargins = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        viewStyle(textField: stackCalculation)
        
//        btnApplyCoupon.layer.cornerRadius = 8
//        txtCouponCode.layer.cornerRadius = 8
//        btnPlaceOrder.layer.cornerRadius = 8
//        stackCalculation.layer.borderColor = UIColor.colorPrimary.cgColor
        
        self.title = "Cart"
        tblCart.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
        
        if app.arrCart.count > 0{
            lblTotal.isHidden = false
            btnPlaceOrder.isHidden = false
        }
        
        else{
            lblTotal.isHidden = true
            btnPlaceOrder.isHidden = true
        }
        
        calculatetotal()
        tblCart.reloadData()
    }
    
    func viewStyle(textField : UIView){
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    func calculatetotal() {
        totalprice = 0.0
        
        for item in app.arrCart {
            totalprice += Double(item.intProductQty ?? 1) * item.doublePrice
        }
        
        lblOriginalPrice.text = "₹\(String(format: "%.2f", totalprice))"
        
        var discountedPrice = totalprice
        
        if isValidCoupon, let code = txtCouponCode.text?.uppercased() {
            stackDiscount.isHidden = false
            
            switch code {
            case "WELCOME10":
                discountedPrice = totalprice * 0.90
            case "DISCOUNT20":
                discountedPrice = totalprice * 0.80
            case "FESTIVE50":
                discountedPrice = totalprice * 0.50
            case "OFF40":
                discountedPrice = totalprice * 0.60
            case "SAVE20":
                discountedPrice = totalprice * 0.80
            case "NEWUSER25":
                discountedPrice = totalprice * 0.75
            case "SUMMER15":
                discountedPrice = totalprice * 0.85
            case "TRY5":
                discountedPrice = totalprice * 0.95
            case "SHOP75":
                discountedPrice = totalprice * 0.25
            case "BIGSALE30":
                discountedPrice = totalprice * 0.70
            case "EXTRA15":
                discountedPrice = totalprice * 0.85
            default:
                discountedPrice = totalprice
            }
            
            lblDiscount.text = "₹\(String(format: "%.2f", discountedPrice))"
        }
        else {
            lblDiscount.text = "₹0.00"
            stackDiscount.isHidden = true
        }
        
        let taxAmount = discountedPrice * taxpersentage
        lblSGST.text = "₹\(String(format: "%.2f", taxAmount))"
        lblCGST.text = "₹\(String(format: "%.2f", taxAmount))"
        
        let finalTotal = discountedPrice + (taxAmount * 2)
        lblTotal.text = "Total: ₹\(String(format: "%.2f", finalTotal))"
    }
    
    @IBAction func btnPlaceOrder(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if let plvc = storyboard.instantiateViewController(withIdentifier: "AddressViewController") as? AddressViewController {
            self.navigationController?.pushViewController(plvc, animated: true)
            
        }
    }
    
    @IBAction func btnApplyCouponClick(_ sender: Any) {
        
        guard let enteredCode = txtCouponCode.text?.uppercased(), !enteredCode.isEmpty else {
            UIAlertController.showAlert(title: "Error", message: "Please enter a coupon code.", viewController: self)
            return
        }
        
        let validCouponCodes = arrcoupan.map { $0.uppercased() }
        
        if isValidCoupon {
            isValidCoupon = false
            txtCouponCode.text = ""
            txtCouponCode.isUserInteractionEnabled = true
            btnApplyCoupon.setTitle("Apply", for: .normal)
        }
        else {
            
            if validCouponCodes.contains(enteredCode) {
                isValidCoupon = true
                txtCouponCode.text = enteredCode
                txtCouponCode.isUserInteractionEnabled = false
                btnApplyCoupon.setTitle("Remove", for: .normal)
            }
            
            else {
                UIAlertController.showAlert(title: "Error", message: "Invalid Coupon", viewController: self)
            }
        }
        calculatetotal()
    }
    
}
