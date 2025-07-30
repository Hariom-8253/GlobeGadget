//
//  ProductModel.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 09/07/25.
//

import Foundation


class ProductModel : Codable{
    var productId : Int = 0
    var strTitle : String = ""
    var doublePrice : Double = 0.0
    var strCategory : String = ""
    var strDescription : String = ""
    var strImageName : String = ""
    var strDescription2 : String = ""
    var addFavouriteProduct : Bool?
    var arrImage : [String] = []
    var intProductQty : Int?
    
    var categoryId : Int = 0
    
    
    init(strTitle: String, doublePrice: Double, strCategory: String, strDescription: String, strImageName: String, strDescription2: String, arrImage : [String]) {
        self.strTitle = strTitle
        self.doublePrice = doublePrice
        self.strCategory = strCategory
        self.strDescription = strDescription
        self.strImageName = strImageName
        self.strDescription2 = strDescription2
        self.arrImage = arrImage
        //        self.objProductCategory = objProductCategory
    }
    
    class func loadProductFromJsonFile() -> [ProductModel]{
        guard let filePath = Bundle.main.url(forResource: "products", withExtension: "json") else{
            print ("ProductData Json File not found")
            return []
        }
        do{
            let data = try Data(contentsOf: filePath)
            let arrproduct = try JSONDecoder().decode([ProductModel].self, from: data)
            print(arrproduct)
            return arrproduct
        }
        catch{
            print(error.localizedDescription)
            
        }
        return []
    }
    
    class func loadCategoryFromJsonFile() -> [CategoryModel]{
        guard let filePath = Bundle.main.url(forResource: "category_data", withExtension: "json") else{
            print ("ProductData Json File not found")
            return []
        }
        do{
            let data = try Data(contentsOf: filePath)
            let arrCategory = try JSONDecoder().decode([CategoryModel].self, from: data)
            print(arrCategory)
            return arrCategory
        }
        catch{
            print(error.localizedDescription)
            
        }
        return []
    }
    
    class func convertToArrayOfDictionaries<T: Encodable>(_ objects: [T]) -> [[String: Any]]? {
        do {
            let data = try JSONEncoder().encode(objects)
            let array = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
            return array
        } catch {
            print("Error converting array to dictionary array: \(error)")
            return nil
        }
    }
    
    class func loadWishlistFromUserDefaults() -> [ProductModel] {
        guard let savedArray = UserDefaults.standard.array(forKey: "WishlistData") as? [[String: Any]] else {
            return []
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: savedArray, options: [])
            let products = try JSONDecoder().decode([ProductModel].self, from: data)
            return products
        } catch {
            print("Error decoding wishlist from UserDefaults:", error.localizedDescription)
            return []
        }
    }
    
}

class CategoryModel : Codable{
    var category_id : Int = 0
    var category_name : String = ""
    var category_display_name : String = ""
}

