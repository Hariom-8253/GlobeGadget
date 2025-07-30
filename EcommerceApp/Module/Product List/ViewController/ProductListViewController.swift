//
//  ProductListViewController.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 09/07/25.
//

import UIKit

//var selectedCategory: ProductCategory = .all


class ProductListViewController: UIViewController {
    
    @IBOutlet weak var heightCollectionView: NSLayoutConstraint!
    @IBOutlet weak var colViewProductList: UICollectionView!
    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblViewProduct: UITableView!
    
    var arrProduct : [ProductModel] = []
    var arrFilteredData : [ProductModel] = []
    var arrCategory : [CategoryModel] = []
    
    var objRedirect: PageType = .ProductList
    var indexSelectedCategory : Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textSearch = [txtSearch!]
        styleViews(textSearch, cornerRadius: 8, borderWidth: 1, borderColor: UIColor.colorPrimary.cgColor)
        txtSearch.setPadding(left: 10, right: 10)
        

        
        let btnSetting = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btnSetting.setBackgroundImage(UIImage(systemName: "gear"), for: .normal)
        btnSetting.addTarget(self, action: #selector(btnSettingAction), for: .touchUpInside)
        
        let btnSetting1 = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btnSetting1.setBackgroundImage(UIImage(systemName: "cart"), for: .normal)
        btnSetting1.addTarget(self, action: #selector(btnSettingCartAction), for: .touchUpInside)
        
        let badgeLabel = UILabel(frame: CGRect(x: 18, y: -5, width: 18, height: 18))
        badgeLabel.tag = 1001
        badgeLabel.text = "0"
        badgeLabel.textColor = .white
        badgeLabel.backgroundColor = .systemRed
        badgeLabel.font = .systemFont(ofSize: 12, weight: .bold)
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 10
        badgeLabel.clipsToBounds = true
        
        btnSetting1.addSubview(badgeLabel)
        
        btnSetting.tintColor = .colorPrimary
        btnSetting1.tintColor = .colorPrimary
        
        
        if objRedirect == .Wishlist {
            
            self.title = "WishList"
            colViewProductList.isHidden = true
            heightCollectionView.constant = 0
            
        }
        
        else{
            
            let productapi = "https://mocki.io/v1/b1aa05fa-246d-44d9-bc51-76c1e3500457"
            let categoryapi = "https://mocki.io/v1/9533ba8d-336c-489b-86b6-fe9e76917dcc"
            
            
            APICalls.getData(from: productapi) {(products: [ProductModel]) in
                DispatchQueue.main.async {
                    self.arrProduct = products
                    self.arrFilteredData = products
                    self.updateWishListData()
                    self.tblViewProduct.reloadData()
                    
                }
            }
            
            APICalls.getData(from: categoryapi) {(categories: [CategoryModel]) in
                DispatchQueue.main.async {
                    self.arrCategory = categories
                    self.colViewProductList.reloadData()
                }
            }
        
            
            if let dict = ProductModel.convertToArrayOfDictionaries(arrProduct) {
                UserDefaults.standard.set(dict, forKey: "ProductList")
                UserDefaults.standard.synchronize()
            }
            self.title = "Product List"
            self.navigationItem.hidesBackButton = true
            self.navigationController?.navigationBar.isHidden = false
            self.navigationItem.rightBarButtonItems =  [UIBarButtonItem(customView: btnSetting), UIBarButtonItem(customView: btnSetting1)]
            
        }
        
        txtSearch.attributedPlaceholder = NSAttributedString(
            string: txtSearch.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        
        arrFilteredData = arrProduct
        tblViewProduct.reloadData()
        
        tblViewProduct.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
        
        colViewProductList.register(UINib(nibName: "ProductListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductListCollectionViewCell")
        
        
        
    }
    
    func updateWishListData() {
        for item in arrProduct{
            if app.wishlistArray.firstIndex(where: { $0.productId == item.productId}) != nil{
                item.addFavouriteProduct = true
            }else {
                item.addFavouriteProduct = false
            }
        }
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if objRedirect == .Wishlist {
            
            if arrFilteredData.count == 0 {
                tblViewProduct.isHidden = true
                lblEmpty.isHidden = false
            } else {
                tblViewProduct.isHidden = false
                lblEmpty.isHidden = true
                txtSearch.isHidden = false
            }
        } else {
            updateWishListData()
            lblEmpty.isHidden = true
            
        }
        
        tblViewProduct.reloadData()
        updateQuantity()
    }
    
    
    @objc func btnSettingAction() {
        let storyboard = UIStoryboard(name: "SettingStoryboard", bundle: nil)
        if let pVC = storyboard.instantiateViewController(withIdentifier: "SettingPageViewController") as? SettingPageViewController {
            pVC.productList = self.arrProduct
            self.navigationController?.pushViewController(pVC, animated: true)
        }
    }
    
    @objc func btnSettingCartAction() {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let pVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            
            self.navigationController?.pushViewController(pVC, animated: true)
        }
    }
    
    func updateQuantity() {
        var totalQuantity = 0
        var totalAmount: Double = 0
        
        for item in app.arrCart {
            totalQuantity += item.intProductQty ?? 1
            totalAmount += Double(item.intProductQty ?? 1) * Double(item.doublePrice)
        }
        
        // Update quantity badge on cart button
        if let btnCart = self.navigationItem.rightBarButtonItems?.last?.customView as? UIButton,
           let lblQuantity = btnCart.viewWithTag(1001) as? UILabel {
            lblQuantity.text = "\(totalQuantity)"
            lblQuantity.isHidden = totalQuantity == 0
        }
    }
    
}
