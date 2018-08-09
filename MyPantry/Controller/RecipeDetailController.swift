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

    var indexPath1: IndexPath!
    var tableView1: UITableView!
    
    //Outlets
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var shorDescriptionLabel: UILabel!
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
            let recipeName = recipeNameLabel.text
            let shortDescription = shorDescriptionLabel.text
            let recipeText = recipeTextLabel.text
            let image = recipeImage.image
            
            let editRecipeController = segue.destination as! EditRecipeController
            
            editRecipeController.recipeName = recipeName
            editRecipeController.shortDescription = shortDescription
            editRecipeController.recipeText = recipeText
            editRecipeController.image = image
            
            let indexPath2 = indexPath1
            editRecipeController.indexPath2 = indexPath2
            let tableView2 = tableView1
            editRecipeController.tableView2 = tableView2
        }
    }
    
    func configureDetail() {
        recipeNameLabel.text = recipeName
        shorDescriptionLabel.text = shortDescription
        recipeImage.image = image
        recipeTextLabel.text = recipeText
    }
    
}
