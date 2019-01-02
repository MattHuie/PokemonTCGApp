//
//  CardsAPIClient.swift
//  PokemonTCGApp
//
//  Created by Matthew Huie on 12/19/18.
//  Copyright © 2018 Matthew Huie. All rights reserved.
//

import Foundation

final class CardsAPIClient {
    static func getCards (completionHandler: @escaping (AppError?, [CardInfo]?) -> Void) {
        let urlString = "https://api.pokemontcg.io/v1/cards?setCode=base1"
        NetworkHelper.performDataTask(urlString: urlString, httpMethod: "GET") { (error, data, response) in
            if let error = error {
                completionHandler(error, nil)
            } else if let data = data {
                do {
                   let cards = try JSONDecoder().decode(PokemonCards.self, from: data)
                    completionHandler(nil, cards.cards)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
}
