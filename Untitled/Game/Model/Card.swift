//
//  Card.swift
//  Untitled
//
//  Created by Julia Conti Mestre on 08/10/20.
//

import SpriteKit

// MARK: - CardType
enum CardType: Int {
  case unknown = 0, character, confetti, dementors, glitter, riotPolice, serpentine, tacticalPolice
  var spriteName: String {
    let spriteNames = [
      "card_character",
      "card_confetti",
      "card_dementors",
      "card_glitter",
      "card_riotPolice",
      "card_serpentine",
      "card_tacticalPolice"]

    return spriteNames[rawValue - 1]
  }
  
  static func random() -> CardType {
    var type = CardType(rawValue: Int(arc4random_uniform(6)) + 1)!
    
    while type == .character {
        type = CardType(rawValue: Int(arc4random_uniform(6)) + 1)!
    }
    
    return type
  }
}

// MARK: - Card
class Card: CustomStringConvertible, Hashable {
    
    var hashValue: Int {
        return row * 10 + column
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(hashValue)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.column == rhs.column && lhs.row == rhs.row

    }

    var description: String {
        return "type:\(cardType) square:(\(column),\(row))"
    }

    var column: Int
    var row: Int
    let cardType: CardType
    var sprite: SKSpriteNode?

    init(column: Int, row: Int, cardType: CardType) {
        self.column = column
        self.row = row
        self.cardType = cardType
    }
}
