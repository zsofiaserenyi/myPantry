//
//  Recipe.swift
//  MyPantry
//
//  Created by Serényi  Zsófia on 2018. 08. 07..
//  Copyright © 2018. Serényi  Zsófia. All rights reserved.
//

import Foundation

class Recipe: NSObject, NSCoding {
    fileprivate var _imagePath: String!
    fileprivate var _name: String!
    fileprivate var _shortDescription: String!
    fileprivate var _recipeText: String!
    
    var imagePath: String {
        return _imagePath
    }
    
    var name: String {
        return _name
    }
    
    var shortDescription: String {
        return _shortDescription
    }
    
    var recipeText: String {
        return _recipeText
    }
    
    init(imagePath: String, name: String, shortDescription: String, recipeText: String) {
        self._imagePath = imagePath
        self._name = name
        self._shortDescription = shortDescription
        self._recipeText = recipeText
    }
    
    override init() {
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self._imagePath, forKey: "imagePath")
        aCoder.encode(self._name, forKey: "name")
        aCoder.encode(self._shortDescription, forKey: "shortDescription")
        aCoder.encode(self._recipeText, forKey: "recipeText")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self._imagePath = aDecoder.decodeObject(forKey: "imagePath") as? String
        self._name = aDecoder.decodeObject(forKey: "name") as? String
        self._shortDescription = aDecoder.decodeObject(forKey: "shortDescription") as? String
        self._recipeText = aDecoder.decodeObject(forKey: "recipeText") as? String
    }

    
}
