//
//  PokemonCards.swift
//  PokemonTCGApp
//
//  Created by Matthew Huie on 12/17/18.
//  Copyright © 2018 Matthew Huie. All rights reserved.
//

import Foundation

struct PokemonCards: Codable {
    let cards: [CardInfo]
}
struct CardInfo: Codable {
    let name: String
    let nationalPokedexNumber: Int?
    let imageUrlHiRes: String
    let types: [String]?
    let supertype: String
    let subtype: String?
    let ability: AbilityInfo?
    let hp: String?
    let attacks: [AttacksInfo]?
    let weaknesses: [WeaknessInfo]?
    let text: [String]?
}
struct AbilityInfo: Codable {
    let name: String?
    let text: String?
}
struct AttacksInfo: Codable {
    let name: String?
    let text: String?
    let damage: String?
}
struct WeaknessInfo: Codable {
    let type: String?
    let value: String?
}
