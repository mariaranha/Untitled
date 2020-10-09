//
//  GameScene.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 07/10/20.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var titleWidth = CGFloat()
    var titleHeight = CGFloat()
    let cardSpace: CGFloat = 6.0

    let gameLayer = SKNode()
    let cardsLayer = SKNode()
    
    var level: Level!
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
  
    init(size: CGSize, level: Level) {
        self.level = level
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)

        addChild(gameLayer)
        
        titleWidth = size.width / CGFloat(level.numColumns)
        titleHeight = size.height / CGFloat(level.numRows)

        let layerPosition = CGPoint(
            x: -titleWidth * CGFloat(level.numColumns) / 2,
            y: -titleHeight * CGFloat(level.numRows) / 2)

        cardsLayer.position = layerPosition
        gameLayer.addChild(cardsLayer)

    }
  
    func addSprites(for cards: Set<Card>) {
        for card in cards {
          let sprite = SKSpriteNode(imageNamed: card.cardType.spriteName)
          sprite.size = CGSize(width: titleWidth - cardSpace, height: titleHeight - cardSpace)
          sprite.position = pointFor(column: card.column, row: card.row)
          cardsLayer.addChild(sprite)
          card.sprite = sprite
        }
    }

    private func pointFor(column: Int, row: Int) -> CGPoint {
        return CGPoint(
          x: CGFloat(column) * titleWidth + titleWidth / 2,
          y: CGFloat(row) * titleHeight + titleHeight / 2)
    }

}


