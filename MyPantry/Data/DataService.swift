//
//  DataService.swift
//  MyPantry
//
//  Created by Serényi  Zsófia on 2018. 08. 07..
//  Copyright © 2018. Serényi  Zsófia. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    static let instance = DataService()
    
    private var _loadedRecipes = [Recipe]()
    
    var loadedRecipes: [Recipe] {
        get {
            return _loadedRecipes
        } set {
            _loadedRecipes = newValue
        }
    }
    
    func saveRecipes() {
        let recipesData = NSKeyedArchiver.archivedData(withRootObject: _loadedRecipes)
        UserDefaults.standard.set(recipesData, forKey: "recipes")
        UserDefaults.standard.synchronize()
    }
    
    func loadRecipes() {
        if let recipesData = UserDefaults.standard.object(forKey: "recipes") as? Data {
            if let recipesArray = NSKeyedUnarchiver.unarchiveObject(with: recipesData) as? [Recipe] {
                _loadedRecipes = recipesArray
            }
        }
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "recipesLoaded"), object: nil))
    }
    
    func saveImageAndCreatePath(image: UIImage) -> String {
        let imgData = UIImagePNGRepresentation(image)
        let imgPath = "image\(Date.timeIntervalSinceReferenceDate).png"
        let fullPath = documentsPathForFileName(imgPath)
        try? imgData?.write(to: URL(fileURLWithPath: fullPath), options: [.atomic])
        return imgPath
    }
    
    func imageForPath(path: String) -> UIImage? {
        let fullPath = documentsPathForFileName(path)
        let image = UIImage(named: fullPath)
        return image
    }
    
    func addRecipe(recipe: Recipe) {
        _loadedRecipes.append(recipe)
        saveRecipes()
        loadRecipes()
    }
    
    func documentsPathForFileName(_ name: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let fullPath = paths[0] as NSString
        return fullPath.appendingPathComponent(name)
    }
}
