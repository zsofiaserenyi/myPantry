//
//  AddRecipeVC.swift
//  MyPantry
//
//  Created by Serényi  Zsófia on 2018. 08. 07..
//  Copyright © 2018. Serényi  Zsófia. All rights reserved.
//

import UIKit

class AddRecipeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker: UIImagePickerController!
    
    //Outlets
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var shortDescriptionField: UITextField!
    @IBOutlet weak var recipeField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        
        recipeImage.layer.cornerRadius = 10
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self

    }
    
    //Actions

    @IBAction func addPicButtonPressed(_ sender: UIButton) {
        sender.setTitle("", for: .normal)
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func addRecipeButtonPressed(_ sender: UIButton) {
        if let name = nameField.text, let shortDescription = shortDescriptionField.text, let recipeText = recipeField.text, let image = recipeImage.image {
            let imagePath = DataService.instance.saveImageAndCreatePath(image: image)
            let recipe = Recipe(imagePath: imagePath, name: name, shortDescription: shortDescription, recipeText: recipeText)
            DataService.instance.addRecipe(recipe: recipe)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //Helper methodes
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePicker.dismiss(animated: true, completion: nil)
        recipeImage.image = selectedImage
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        hideKeyboard()
        return true
    }



}

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
