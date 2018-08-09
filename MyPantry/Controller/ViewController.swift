//
//  ViewController.swift
//  MyPantry
//
//  Created by Serényi  Zsófia on 2018. 08. 07..
//  Copyright © 2018. Serényi  Zsófia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    //Outlets
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    
        DataService.instance.loadRecipes()
        
        
        // Reload data on main view
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.onRecipesLoaded(_:)), name: NSNotification.Name(rawValue: "recipesLoaded"), object: nil)
        
        //Reload changed recipe
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.changedRecipeLoaded(_:)), name: NSNotification.Name(rawValue: "saveChanges"), object: nil)
    }
    
    //TableView methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let recipe = DataService.instance.loadedRecipes[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell") as? RecipeCell {
            cell.configureCell(recipe)
            return cell
        }
        return RecipeCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.loadedRecipes.count
    }
    
    //Actions
    
    @IBAction func clearAll(_ sender: Any) {
        popAlertMessage()
    }
    
    
    //Helper methodes
    
    @objc func onRecipesLoaded(_ notif: AnyObject) {
        tableView.reloadData()
    }
    
    @objc func changedRecipeLoaded(_ notif: AnyObject) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        DataService.instance.loadedRecipes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataService.instance.loadedRecipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let recipe = tableView(tableView, cellForRowAt: indexPath) as! RecipeCell
            let recipeName = recipe.nameLabel.text
            let shortDescription = recipe.shortDescriptionLabel.text
            let recipeImage = recipe.recipeImage.image
            let recipeText = recipe.recipeTextLabel.text
            
            let detailViewController = segue.destination as! RecipeDetailController
            
            detailViewController.recipeName = recipeName
            detailViewController.shortDescription = shortDescription
            detailViewController.image = recipeImage
            detailViewController.recipeText = recipeText
        }
    }
    
    func popAlertMessage() {
        let alert = UIAlertController(title: "Delete ALL Recipes?", message: "Are you sure you want to delete all your recipes?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { action in
            self.dismissAlertController()
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { action in
            let numberOfRecipes = self.tableView.numberOfRows(inSection: 0)
            DataService.instance.loadedRecipes.removeAll()
            self.tableView.deleteRows(at: (0..<numberOfRecipes).map({ (i) in IndexPath(row: i, section: 0)}), with: .automatic)
        }))
        present(alert, animated: true)
    }
    
    @objc func dismissAlertController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    // Navigation Bar White Color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


