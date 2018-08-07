//
//  RecipeCellTableViewCell.swift
//  MyPantry
//
//  Created by Serényi  Zsófia on 2018. 08. 07..
//  Copyright © 2018. Serényi  Zsófia. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    // Outlets
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        recipeImage.layer.cornerRadius = 5
    }
    
    func configureCell(_ recipe: Recipe) {
        nameLabel.text = recipe.name
        shortDescriptionLabel.text = recipe.shortDescription
        recipeImage.image = DataService.instance.imageForPath(path: recipe.imagePath)
    }


}
