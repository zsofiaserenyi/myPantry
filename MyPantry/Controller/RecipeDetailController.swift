//
//  RecipeDetailController.swift
//  MyPantry
//
//  Created by Serényi  Zsófia on 2018. 08. 08..
//  Copyright © 2018. Serényi  Zsófia. All rights reserved.
//

import UIKit

class RecipeDetailController: UIViewController {
    
    var recipe: RecipeCell!
    
    //Outlets
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTextLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeImage.layer.cornerRadius = 10
        configureDetail()
    }

    //Actions
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // Helper methodes
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editRecipe" {
            let currentRecipe = recipe
            
            let editRecipeController = segue.destination as! EditRecipeController
            editRecipeController.recipe = currentRecipe
        }
    }
    
    func configureDetail() {
        recipeNameLabel.text = recipe.nameLabel.text
        shortDescriptionLabel.text = recipe.shortDescriptionLabel.text
        recipeImage.image = recipe.recipeImage.image
        recipeTextLabel.text = recipe.recipeTextLabel.text
    }
    
    // Navigation Bar White Color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
