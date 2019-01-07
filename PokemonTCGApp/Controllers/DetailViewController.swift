//
//  DetailViewController.swift
//  PokemonTCGApp
//
//  Created by Matthew Huie on 12/19/18.
//  Copyright © 2018 Matthew Huie. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var cardImage: UIImageView!
    
    var pokeCard: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    func updateUI() {
        if let url = pokeCard{
            ImageHelper.shared.fetchImage(urlString: url) { (error, image) in
                if let error = error {
                    print("error at imagehelper \(error)")
                } else if let image = image {
                    self.cardImage.image = image
                }
            }
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
