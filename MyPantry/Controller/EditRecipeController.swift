//
//  EditRecipeController.swift
//  MyPantry
//
//  Created by Serényi  Zsófia on 2018. 08. 09..
//  Copyright © 2018. Serényi  Zsófia. All rights reserved.
//

import UIKit

class EditRecipeController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var recipeName: String!
    var shortDescription: String!
    var recipeText: String!
    var image: UIImage!
    
    var indexPath2: IndexPath!
    var tableView2: UITableView!
    
    var imagePicker: UIImagePickerController!
    
    //Outlets
    
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UITextField!
    @IBOutlet weak var shortDescriptionLabel: UITextField!
    @IBOutlet weak var recipeTextLabel: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.instance.loadedRecipes.remove(at: indexPath2.row)
        tableView2.deleteRows(at: [indexPath2], with: .fade)
        
        recipeImage.layer.cornerRadius = 10
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self

        configureView()
    }

    //Actions
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func changePicture(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func saveChanges(_ sender: Any) {
        if let name = recipeNameLabel.text, let shortDescription = shortDescriptionLabel.text, let recipeText = recipeTextLabel.text, let image = recipeImage.image {
            let imagePath = DataService.instance.saveImageAndCreatePath(image: image)
            let recipe = Recipe(imagePath: imagePath, name: name, shortDescription: shortDescription, recipeText: recipeText)
            DataService.instance.addRecipe(recipe: recipe)
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    //Helper methodes
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePicker.dismiss(animated: true, completion: nil)
        recipeImage.image = selectedImage
    }
    
    func configureView() {
        recipeNameLabel.text = recipeName
        shortDescriptionLabel.text = shortDescription
        recipeTextLabel.text = recipeText
        recipeImage.image = image
    }
    
    
}
