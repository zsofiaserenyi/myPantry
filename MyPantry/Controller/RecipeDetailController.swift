//
//  RecipeDetailController.swift
//  MyPantry
//
//  Created by Serényi  Zsófia on 2018. 08. 08..
//  Copyright © 2018. Serényi  Zsófia. All rights reserved.
//

import UIKit

class RecipeDetailController: UIViewController {

    var recipeName: String!
    var shortDescription: String!
    var image: UIImage!
    var recipeText: String!
    
    //Outlets
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var shorDescriptionLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTextLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureDetail()
    }

    //Actions
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // Helper methodes
    
    func configureDetail() {
        recipeNameLabel.text = recipeName
        shorDescriptionLabel.text = shortDescription
        recipeImage.image = image
        recipeTextLabel.text = recipeText
    }
    
}
