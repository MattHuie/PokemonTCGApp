//
//  CardsAPIClient.swift
//  PokemonTCGApp
//
//  Created by Matthew Huie on 12/17/18.
//  Copyright © 2018 Matthew Huie. All rights reserved.
//

import Foundation

enum AppError {
    case badURL(String)
    case badData(Error)
    case badDecoding(Error)
}

final class CardsAPIClient {
    static func getAllCards(completionHandler: @escaping (([CardInfo]?, AppError?) -> Void)) {
        guard let url = URL.init(string: "https://api.pokemontcg.io/v1/cards?setCode=base1") else { completionHandler(nil, .badURL("URL not working"))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(nil, .badData(error))
            } else if let data = data {
                do {
                    let card = try JSONDecoder().decode(PokemonCards.self, from: data)
                    completionHandler(card.cards, nil)
                } catch {
                    completionHandler(nil, .badDecoding(error))
                }
            }
        }.resume()
    }
}
