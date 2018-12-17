//
//  ViewController.swift
//  PokemonTCGApp
//
//  Created by Matthew Huie on 12/17/18.
//  Copyright © 2018 Matthew Huie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cardsTableView: UITableView!
    
    var pokemonCards = [CardInfo]() {
        didSet{
            DispatchQueue.main.async {
                self.cardsTableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cardsTableView.dataSource = self
        cardsTableView.delegate = self
        CardsAPIClient.getAllCards { (pokemonCards, error) in
            if let error = error {
                print("error: \(error)")
            }
            if let pokemonCards = pokemonCards {
                self.pokemonCards = pokemonCards
            }
        }
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(pokemonCards.count)
        return pokemonCards.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cardsTableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as? CardsTableViewCell else {return UITableViewCell()}
        let cardToSet = pokemonCards[indexPath.row]
        cell.cardNameLabel.text = "Name: \(cardToSet.name)"
        cell.superTypeLabel.text = "Card Type: \(cardToSet.supertype)"
        
        DispatchQueue.main.async {
            if let url = URL.init(string: cardToSet.imageUrlHiRes) {
                do {
                    let data = try Data.init(contentsOf: url)
                    if let image = UIImage.init(data: data) {
                        cell.cardImage.image = image
                    }
                } catch {
                    print("immage error: \(error)")
                }
            }
        }
      
        return cell
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

