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
        
        let photo = Card(column: photoColumn, row: photoRow, cardType: CardType(rawValue: 7)!, value: 0)
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
        guard (column >= 0 && column < numColumns) else { return nil}
        guard (row >= 0 && row < numRows) else { return nil }
        
        return cards[column, row]
    }
    
    func performMove(_ move: MoveCard) {
        cards[move.cardA.column, move.cardA.row] = move.newCard
        
        cards[move.cardB.column, move.cardB.row] = move.cardA
        move.cardA.column = move.cardB.column
        move.cardA.row = move.cardB.row
    }
}
