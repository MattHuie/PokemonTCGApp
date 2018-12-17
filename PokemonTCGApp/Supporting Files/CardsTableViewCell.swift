//
//  CardsTableViewCell.swift
//  PokemonTCGApp
//
//  Created by Matthew Huie on 12/17/18.
//  Copyright © 2018 Matthew Huie. All rights reserved.
//

import UIKit

class CardsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var superTypeLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
