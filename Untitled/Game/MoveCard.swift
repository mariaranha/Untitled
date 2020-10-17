//
//  MoveCard.swift
//  Untitled
//
//  Created by Julia Conti Mestre on 13/10/20.
//

struct MoveCard: CustomStringConvertible {
    let cardA: Card
    let cardB: Card
    let newCard: Card
  
    init(cardA: Card, cardB: Card, newCard: Card) {
        self.cardA = cardA
        self.cardB = cardB
        self.newCard = newCard
    }

    var description: String {
        return "Move \(cardA) to \(cardB) position. Add \(newCard)"
    }
}

struct FirstMove: CustomStringConvertible {
    let toCard: Card
    let characterCard: Card
    
    init(toCard: Card, characterCard: Card) {
        self.toCard = toCard
        self.characterCard = characterCard
    }
    
    var description: String {
        return "First move \(characterCard) to \(toCard) position"
    }
}
