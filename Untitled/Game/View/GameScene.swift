//
//  GameScene.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 07/10/20.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var tileWidth = CGFloat()
    var tileHeight = CGFloat()
    var cardSpace: CGFloat = 12.0

    let gameLayer = SKNode()
    let tilesLayer = SKNode()
    let cardsLayer = SKNode()
    
    var level: Level!
    
    var moveHandler: ((MoveCard) -> Void)?
    var lifeLayoutHandler: ((Int) -> Void)?
    var energyLayoutHandler: ((Int) -> Void)?
    
    let gameViewController:GameViewController = GameViewController()
    
    var canExit = false
    
    enum Moves {
        case up
        case down
        case right
        case left
        case first
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
  
    init(size: CGSize, level: Level, tileSize: CGSize) {
        self.level = level
        super.init(size: size)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        tileHeight = tileSize.height
        tileWidth = tileSize.width
        
        // Set cardsLayer in center
        let layerPosition = CGPoint(
            x: -tileWidth * CGFloat(level.numColumns) / 2,
            y: -tileHeight * CGFloat(level.numRows) / 2)

        addChild(gameLayer)
        cardsLayer.position = layerPosition
        tilesLayer.position = layerPosition
        gameLayer.addChild(tilesLayer)
        gameLayer.addChild(cardsLayer)
    }
    
    func addTiles() {
        enum TileType {
            case topLeft
            case topRight
            case bottomLeft
            case bottomRight
            case up
            case down
            case left
            case right
            case middle
        }
        
        var tileType: TileType!
        
        for row in 1...level.numRows {
            for column in 1...level.numColumns {
                if column == 1 && row == level.numRows {
                    tileType = .topLeft
                } else if column == 1 && row == 1 {
                    tileType = .bottomLeft
                } else if column == level.numColumns && row == level.numRows {
                    tileType = .topRight
                } else if column == level.numColumns && row == 1 {
                    tileType = .bottomRight
                } else if column > 1 && column < level.numColumns && row == 1 {
                    tileType = .down
                } else if column > 1 && column < level.numColumns && row == level.numRows {
                    tileType = .up
                } else if column == 1 && row > 1 && row < level.numRows {
                    tileType = .left
                } else if column == level.numColumns && row > 1 && row < level.numRows {
                    tileType = .right
                } else if column > 1 && column < level.numColumns && row > 1 && row < level.numRows {
                    tileType = .middle
                }
                

                let tileName: String
                var tileValue: Int
                
                switch tileType {
                case .bottomRight:
                    tileValue = 4
                case .bottomLeft:
                    tileValue = 2
                case .topRight:
                    tileValue = 3
                case .topLeft:
                    tileValue = 1
                case .up:
                    tileValue = 7
                case .down:
                    tileValue = 8
                case .left:
                    tileValue = 5
                case .right:
                    tileValue = 6
                case .middle:
                    tileValue = 9
                case .none:
                    tileValue = 9
                }
                
                tileName = "tile_\(tileValue)"
                
                let tileNode = SKSpriteNode(imageNamed: tileName)
                tileNode.size = CGSize(width: tileWidth, height: tileHeight)
                let point = pointFor(column: column - 1, row: row - 1)
                tileNode.position = point
                tilesLayer.addChild(tileNode)
            }
          }
    }
    
    override func didMove(to view: SKView) {
        addGestures(view)
    }
    
    func addInitialSprites(for cards: Set<Card>) {
        for card in cards {
          setSprite(card)
        }
    }
    
    // Add sprite to cards layer
    fileprivate func setSprite(_ card: Card) {
        let sprite = SKSpriteNode(imageNamed: card.cardType.setSpriteValue(cardType: card.cardType, cardValue: card.value))
        sprite.size = CGSize(width: tileWidth - cardSpace, height: tileHeight - cardSpace)
        sprite.position = pointFor(column: card.column, row: card.row)
        cardsLayer.addChild(sprite)
        card.sprite = sprite
    }

    private func pointFor(column: Int, row: Int) -> CGPoint {
        return CGPoint(
          x: CGFloat(column) * tileWidth + tileWidth / 2,
          y: CGFloat(row) * tileHeight + tileHeight / 2)
    }
    
    // MARK: Tap Gesture
    fileprivate func convertTouchCoordinate(_ touchLocation: inout CGPoint) {
        //Invert y coordinate
        touchLocation.y = (view!.frame.height - touchLocation.y)
        //Translate view coordinate
        touchLocation.y += -(tileHeight * CGFloat(level.numRows) - view!.frame.height)/2
        touchLocation.x += -(tileWidth * CGFloat(level.numColumns) - view!.frame.width)/2
    }
    
    @objc func tap(sender: UITapGestureRecognizer) {
        var touchLocation = sender.location(ofTouch: 0, in: view)
        convertTouchCoordinate(&touchLocation)
        
        guard let characterPosition = getCharacterPosition() else { return }
        
        let cardUp = (point: pointFor(column: characterPosition.column,
                                      row: characterPosition.row + 1),
                      move: Moves.up)
        let cardDown = (point: pointFor(column: characterPosition.column,
                                        row: characterPosition.row - 1),
                        move: Moves.down)
        let cardRight = (point: pointFor(column: characterPosition.column + 1,
                                         row: characterPosition.row),
                         move: Moves.right)
        let cardLeft = (point: pointFor(column: characterPosition.column - 1,
                                         row: characterPosition.row),
                        move: Moves.left)
        let possibleCards = [cardUp, cardDown, cardRight, cardLeft]
        
        for card in possibleCards {
            let cardFrame = CGRect(x: card.point.x-tileWidth/2,
                                   y: card.point.y-tileHeight/2,
                                   width: tileWidth,
                                   height: tileHeight)
            
            if cardFrame.contains(touchLocation) {
                tryMove(move: card.move)
                break
            }
        }
    }
    
    // MARK: Swipe Gestures
    @objc func swipeRight(sender: UISwipeGestureRecognizer) {
        tryMove(move: .right)
    }
    
    @objc func swipeLeft(sender: UISwipeGestureRecognizer) {
        tryMove(move: .left)
    }
    
    @objc func swipeUp(sender: UISwipeGestureRecognizer) {
        tryMove(move: .up)
    }
    
    @objc func swipeDown(sender: UISwipeGestureRecognizer) {
        tryMove(move: .down)
    }
    
    // MARK: Move
    func tryMove(move: Moves) {
        let moveFrom = getCharacterPosition()
        
        guard let levelData = LevelData.loadFrom(file: "Level_1") else { return }
        
        guard moveFrom != nil else { return }
        guard let fromCard = level.card(atColumn: moveFrom!.column,
                                        row: moveFrom!.row) else { return }
        
        let energyValue = levelData.energyCity
        let photoRow = levelData.photoPosition["row"]!
        let photoColumn = levelData.photoPosition["column"]!
        let exitRow = levelData.exitPosition[0]["row"]!
        
        var moveTo = moveFrom

        switch move {
        case .up:
            moveTo?.row += 1
        case .down:
            moveTo?.row -= 1
        case .right:
            moveTo?.column += 1
        case .left:
            moveTo?.column -= 1
        case .first:
            break
        }
        
        guard let toCard = level.card(atColumn: moveTo!.column,
                                      row: moveTo!.row) else { return }
        
        let newCardType = CardType.random(filename: "Level_1")
        let newCardValue = Card.setCardValue(filename: "Level_1", cardType: newCardType)
        let newCard = Card(column: fromCard.column, row: fromCard.row, cardType: newCardType, value: newCardValue)
        
        if let handler = moveHandler {
            if toCard == Card(column: photoColumn, row: photoRow, cardType: CardType(rawValue: 7)!, value: 0)  {
                if gameViewController.energyProgress.value >= energyValue {
                    let move = MoveCard(cardA: fromCard, cardB: toCard, newCard: newCard)
                    handler(move)
                    canExit = true
                }else{
                    print("Complete a energia da cidade para coletar a foto")
                }
            }else{
                if canExit == true{
                    if toCard.row == exitRow{
                        for index in 0...levelData.exitPosition.count-1{
                            if toCard.column == levelData.exitPosition[index]["column"]!{
                                print("Venceu")
                                break
                            }
                        }
                    }
                }
                let move = MoveCard(cardA: fromCard, cardB: toCard, newCard: newCard)
                handler(move)
                
                if toCard.cardType == .block || toCard.cardType == .tacticalPolice{
                    gameViewController.energyProgress.updateValue(value: toCard.value, type: .city)
                    guard let energyLayout = energyLayoutHandler else { return }
                    energyLayout(gameViewController.energyProgress.value)
                    
                }else if toCard.cardType == .photoRoll || toCard.cardType == .riotPolice{
                    gameViewController.lifeProgress.updateValue(value: toCard.value, type: .character)
                    guard let lifeLayout = lifeLayoutHandler else { return }
                    lifeLayout(gameViewController.lifeProgress.value)
                }
                

//                print("Tipo da carta: \(toCard.cardType)")
//                print("Valor da carta: \(toCard.value)")
//                print("Energia: \(gameViewController.energyProgress.value)")
//                print("Vida: \(gameViewController.lifeProgress.value)")
                
                if gameViewController.lifeProgress.value == 0{
                    print("Game Over")
                }
            }
        }
    }
    
    fileprivate func getCharacterPosition() -> (column: Int, row: Int)? {
        var position = (column: 0, row: 0)
        let numColumns = level.numColumns
        let numRows = level.numRows
        
        for row in 0..<numRows {
            for column in 0..<numColumns {
                let card = level.card(atColumn: column, row: row)
                if card?.cardType == CardType.character {
                    position.column = column
                    position.row = row
                    
                    return position
                }
            }
        }
        
        return nil
    }
    
    fileprivate func addGestures(_ view: SKView) {
        let swipeRight = UISwipeGestureRecognizer(target: self,
                                                  action: #selector(GameScene.swipeRight(sender:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(GameScene.swipeLeft(sender:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self,
                                               action: #selector(GameScene.swipeUp(sender:)))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(GameScene.swipeDown(sender:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        
        
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(GameScene.tap(sender:)))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: Animate Move 
    
    func animateMove(_ move: MoveCard, completion: @escaping () -> Void) {
        let spriteA = move.cardA.sprite!
        let spriteB = move.cardB.sprite!
        
        spriteA.zPosition = 100
        
        let duration: TimeInterval = 0.5

        let moveA = SKAction.move(to: spriteB.position, duration: duration)
        moveA.timingMode = .easeOut
        spriteA.run(moveA, completion: completion)

        let removeB = SKAction.removeFromParent()
        removeB.timingMode = .easeOut
        spriteB.run(removeB)
        
        setSprite(move.newCard)
    }

}


