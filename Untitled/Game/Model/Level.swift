//
//  Level.swift
//  Untitled
//
//  Created by Julia Conti Mestre on 08/10/20.
//

import Foundation

class Level {
    
    private var tiles: Array2D<Tile>
    private var cards: Array2D<Card>
    
    var numRows: Int {
        return tiles.rows
    }
    
    var numColumns: Int {
        return tiles.columns
    }
    
    init?(filename: String) {
        guard let levelData = LevelData.loadFrom(file: filename) else { return nil }
        
        let tilesArray = levelData.tiles
        let numRows = tilesArray.count
        let numColumns = tilesArray[0].count
        
        tiles = Array2D<Tile>(columns: numColumns, rows: numRows)
        cards = Array2D<Card>(columns: numColumns, rows: numRows)

        for (row, rowArray) in tilesArray.enumerated() {

            let tileRow = numRows - row - 1

            for (column, value) in rowArray.enumerated() {
              if value == 1 {
                tiles[column, tileRow] = Tile()
              }
            }
        }
    }

    func createInitialCards(filename: String) -> Set<Card> {
        var set: Set<Card> = []
        
        guard let levelData = LevelData.loadFrom(file: filename) else { return set }
        
        let photoRow = levelData.photoPosition["row"]!
        let photoColumn = levelData.photoPosition["column"]!
        
        let characterRow = levelData.characterPosition["row"]!
        let characterColumn = levelData.characterPosition["column"]!
        
        let photo = Card(column: photoColumn, row: photoRow, cardType: .photo, value: 0)
        cards[photoColumn, photoRow] = photo
        
        let character = Card(column: characterColumn, row: characterRow, cardType: CardType(rawValue: 1)!, value: 0)
        cards[characterColumn,characterRow] = character

        set.insert(photo)
        set.insert(character)
        

        for row in 0..<numRows {
            for column in 0..<numColumns {
                if tiles[column, row] != nil {
                    if (row != photoRow || column != photoColumn) && (row != characterRow || column != characterColumn) {
                        let cardType = CardType.random(filename: filename)
                        let cardValue = Card.setCardValue(filename: filename, cardType: cardType)
                        
                        let card = Card(column: column, row: row, cardType: cardType, value: cardValue)
                        cards[column, row] = card

                        set.insert(card)
                    }
                }
            }
        }
        return set
    }
    
    func card(atColumn column: Int, row: Int) -> Card? {
        guard (column >= 0 && column < numColumns) else { return nil }
        guard (row >= 0 && row < numRows) else { return nil }
        
        return cards[column, row]
    }
    
    func tile(column: Int, row: Int) -> Tile? {
        guard (column >= 0 && column < numColumns) else { return nil }
        guard (row >= 0 && row < numRows) else { return nil }
        return tiles[column, row]
    }
    
    func performMove(_ move: MoveCard) {
        cards[move.cardA.column, move.cardA.row] = move.newCard
        
        cards[move.cardB.column, move.cardB.row] = move.cardA
        move.cardA.column = move.cardB.column
        move.cardA.row = move.cardB.row
    }
    
    func createRewardCard(playerColumn:Int, playerRow: Int, rewardType: CardType, exitPositions: [[String: Int]]) -> Card{
        let elementsColumn: [Int] = [0,4]
        var rewardColumn: Int
        var rewardRow: Int
        
        if playerColumn == 2{
            rewardColumn = elementsColumn.randomElement()!
        } else if playerColumn < 2{
            rewardColumn = playerColumn + 2
        } else {
            rewardColumn = playerColumn - 2
        }
        
        rewardRow = Int.random(in: 0...4)
        while rewardRow == playerRow {
            rewardRow = Int.random(in: 0...4)
        }
        
        for index in 0...exitPositions.count-1{
            if rewardColumn == exitPositions[index]["column"]!{
                while rewardRow == playerRow || rewardRow == exitPositions[0]["row"]{
                    rewardRow = Int.random(in: 0...4)
                }
            }
        }
        
        let rewardCard = Card(column: rewardColumn, row: rewardRow, cardType: rewardType, value: 0)
        return rewardCard
    }
    
    func setCard(newCard: Card){
        cards[newCard.column,newCard.row] = newCard
    }
    
    func createNewCard(column: Int, row: Int, filename: String) -> Card{
        let newCardType = CardType.random(filename: filename)
        let newCardValue = Card.setCardValue(filename: filename, cardType: newCardType)
        let newCard = Card(column: column, row: row, cardType: newCardType, value: newCardValue)
        
        return newCard
    }
    
    func checkExitPosition(toCard: Card, filename: String) -> Bool{
        
        guard let levelData = LevelData.loadFrom(file: filename) else { return false }
        let exitRow = levelData.exitPosition[0]["row"]!
        var win = false
        
        if toCard.row == exitRow{
            for index in 0...levelData.exitPosition.count-1{
                if toCard.column == levelData.exitPosition[index]["column"]!{
                    win = true
                }
            }
        }
        
        return win
    }
    
    
}
