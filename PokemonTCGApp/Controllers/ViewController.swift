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
    @IBOutlet weak var searchBar: UISearchBar!
    
    
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
        searchBar.delegate = self
        searchCards()
    }
    @objc func cardSegue(time: Timer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "secondVC") as! DetailViewController
        let pokeCard = time.userInfo as? String
        detailVC.pokeCard = pokeCard
        
        present(detailVC, animated: true, completion: nil)
    }
    private func searchCards() {
        CardsAPIClient.getCards(keyword: "") { (error, cards) in
            if let error = error {
                print(error.errorMessage())
            } else {
                if let cards = cards {
                    self.pokemonCards = cards
                }
            }
        }
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cardsTableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as? CardsTableViewCell else {return UITableViewCell()}
        let cardToSet = pokemonCards[indexPath.row]
        cell.cardNameLabel.text = "Name: \(cardToSet.name)"
        cell.superTypeLabel.text = "Card Type: \(cardToSet.supertype)"
        cell.cardImage.image = UIImage(named: "pokemonCardBack")
        return cell
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Pokemon TCG Base Set"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = cardsTableView.cellForRow(at: indexPath) as! CardsTableViewCell
        CardsAPIClient.getCards(keyword: "") { (error, cards) in
            if let error = error {
                print(error.errorMessage())
            } else if let cards = cards {
                if let urlImage = cards[indexPath.row].imageUrlHiRes {
                    ImageHelper.shared.fetchImage(urlString: urlImage) { (error, image) in
                        if let error = error {
                            print("error at imagehelper \(error)")
                        } else if let image = image {
                            cell.cardImage.image = image
                            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.cardSegue), userInfo: urlImage, repeats: false)
                        }
                    }
                }
            }
        }
    }
}
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let keyword = searchBar.text {
            CardsAPIClient.getCards(keyword: keyword) { (error, card) in
                if let error = error {
                    print("Error: \(error)")
                } else if let card = card {
                    self.pokemonCards = card
                }
            }
        }
        searchBar.resignFirstResponder()
    }
}
