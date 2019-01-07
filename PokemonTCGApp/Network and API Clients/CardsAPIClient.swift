//
//  CardsAPIClient.swift
//  PokemonTCGApp
//
//  Created by Matthew Huie on 12/19/18.
//  Copyright © 2018 Matthew Huie. All rights reserved.
//

import Foundation

final class CardsAPIClient {
    static func getCards (keyword: String, completionHandler: @escaping (AppError?, [CardInfo]?) -> Void) {
        let urlString = "https://api.pokemontcg.io/v1/cards?setCode=base1"
        NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (error, data, response) in
            if let error = error {
                completionHandler(error, nil)
            } else if let data = data {
                do {
                    if keyword.isEmpty {
                        let cards = try JSONDecoder().decode(PokemonCards.self, from: data)
                        completionHandler(nil, cards.cards)
                    } else {
                        let cards = try JSONDecoder().decode(PokemonCards.self, from: data)
                        completionHandler(nil, cards.cards.filter{$0.name.lowercased().contains(keyword.lowercased())})
                    }
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
}
