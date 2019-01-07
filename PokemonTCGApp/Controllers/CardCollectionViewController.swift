//
//  CardCollectionViewController.swift
//  PokemonTCGApp
//
//  Created by Matthew Huie on 1/7/19.
//  Copyright © 2019 Matthew Huie. All rights reserved.
//

import UIKit

class CardCollectionViewController: UIViewController {

    @IBOutlet weak var cardsCollection: UICollectionView!
    
    var cards = [CardInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.cardsCollection.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardsCollection.dataSource = self
        getAllCards()

       
    }
    
    func getAllCards() {
        CardsAPIClient.getCards(keyword: "") { (error, cards) in
            if let error = error {
                print(error.errorMessage())
            } else {
                if let cards = cards {
                    self.cards = cards
                }
            }
        }
        
    }
    


}

extension CardCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cardsCollection.dequeueReusableCell(withReuseIdentifier: "PokeCardCell", for: indexPath) as! PokeCollectionViewCell
        let cardInfo = cards[indexPath.row]
        cell.configureCell(card: cardInfo)      
        return cell
    }
}
