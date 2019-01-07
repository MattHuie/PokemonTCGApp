//
//  PokeCollectionViewCell.swift
//  PokemonTCGApp
//
//  Created by Matthew Huie on 1/7/19.
//  Copyright © 2019 Matthew Huie. All rights reserved.
//

import UIKit

class PokeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var urlString = ""
    public func configureCell(card: CardInfo) {
        
        
        guard let imageURLString = card.imageUrlHiRes else {
            return
        }
        
        urlString = imageURLString
    
        if let image = ImageHelper.shared.image(forKey: imageURLString as NSString) {
            cardImage.image = image
        } else {
            activityIndicator.startAnimating()
            ImageHelper.shared.fetchImage(urlString: imageURLString) { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    if self.urlString == imageURLString {
                        self.cardImage.image = image
                    }
                }
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    
}
