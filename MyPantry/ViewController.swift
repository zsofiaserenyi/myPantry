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
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.onRecipesLoaded(_:)), name: NSNotification.Name(rawValue: "recipesLoaded"), object: nil)
        
        // Want to clear main page
        /*DataService.instance.loadedRecipes.remove(at: 0)
        let indexPath = IndexPath(item: 0, section: 0)
        tableView.deleteRows(at: [indexPath], with: .fade)
        */
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
    
    //Helper methodes
    
    @objc func onRecipesLoaded(_ notif: AnyObject) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataService.instance.loadedRecipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
    // Navigation Bar White Color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

