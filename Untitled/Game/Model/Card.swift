//
//  Card.swift
//  Untitled
//
//  Created by Julia Conti Mestre on 08/10/20.
//

import SpriteKit

// MARK: - CardType
enum CardType: Int {
    case unknown = 0, character, block, photoRoll, conservator, riotPolice, tacticalPolice, photo
    var spriteName: String {
        let spriteNames = [
            "card_character",
            "card_block",
            "card_photoRoll",
            "card_dementors",
            "card_riotPolice",
            "card_tacticalPolice",
            "photo"]
        
        return spriteNames[rawValue - 1]
    }
    
    static func random(filename: String) -> CardType {
        var type: CardType = CardType(rawValue: Int(arc4random_uniform(6)) + 1)!
        let randomDouble = Double.random(in: 0..<1)
        var total: Double = 0
        
        guard let levelData = LevelData.loadFrom(file: filename) else{
            while type == .character {
                type = CardType(rawValue: Int(arc4random_uniform(6)) + 1)!
                
            }
            return type
        }
     
        let percentage = levelData.randomPercentage
        
        for index in 2...6 {
            total += percentage[index-2]
            if randomDouble <= total{
                type = CardType(rawValue: index)!
                break
            }
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
    let value: Int
    
    init(column: Int, row: Int, cardType: CardType, value: Int) {
        self.column = column
        self.row = row
        self.cardType = cardType
        self.value = value
    }
    
    static func setCardValue(filename: String, cardType: CardType) -> Int{
        let random = Double.random(in: 0..<1)
        var total: Double = 0
        var percentageVector: [Double]  = []
        var valuesVector: [Int] = []
        var value = 0
        guard let levelData = LevelData.loadFrom(file: filename) else{
            return value
        }
       
        if cardType == .block{
            percentageVector = levelData.blockValuePercentage
            valuesVector = levelData.blockValue
        }else if cardType == .photoRoll{
            percentageVector = levelData.photoRollValuePercentage
            valuesVector = levelData.photoRollValue
        }else if cardType == .riotPolice{
            percentageVector = levelData.riotPoliceValuePercentage
            valuesVector = levelData.riotPoliceValue
        }else if cardType == .tacticalPolice{
            percentageVector = levelData.tacticalPoliceValuePercentage
            valuesVector = levelData.tacticalPoliceValue
        }else if cardType == .conservator{
            return value
        }
        
        
        for index in 0 ... valuesVector.count-1{
            total += percentageVector[index]
            if random <= total{
                value = valuesVector[index]
                break
            }
        }

        return value
    }
}
