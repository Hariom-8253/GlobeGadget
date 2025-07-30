//
//  AppDelegate.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 09/07/25.
//

import UIKit
import CoreData

var app = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var arrCart : [ProductModel] = []
    var wishlistArray: [ProductModel] = []
    
    //CoreData
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model") // your .xcdatamodeld name
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let customColor = UIColor(named: "colorPrimary") {
            let appearance = UINavigationBar.appearance()
            
            // Title text color
            appearance.titleTextAttributes = [
                .foregroundColor: customColor
            ]
            
            // Back button arrow & text color
            appearance.tintColor = customColor
        }
        
        // To Set Colour to the back button and its text
        let appearance = UINavigationBar.appearance()
        appearance.tintColor = UIColor.colorPrimary  // Arrow color
        appearance.titleTextAttributes = [.foregroundColor: UIColor.colorPrimary] // Title color
        
        if let data = UserDefaults.standard.value(forKey: "wishList"){
            do{
                let arr = try JSONDecoder().decode([ProductModel].self, from: data as! Data)
                wishlistArray = arr
            }catch{
                print(error)
            }
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        do{
            let data = try JSONEncoder().encode(app.wishlistArray)
            UserDefaults.standard.set(data, forKey: "wishList")
            UserDefaults.standard.synchronize()
        }catch{
            print(error)
        }
    }
    
    
}

