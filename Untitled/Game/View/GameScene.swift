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
    var cardSpace: CGFloat = 10.0

    let cardsLayer = SKNode()
    
    var level: Level!
    
    var moveHandler: ((MoveCard) -> Void)?
    var lifeLayoutHandler: ((Int) -> Void)?
    
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

        cardsLayer.position = layerPosition
        addChild(cardsLayer)
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
        let sprite = SKSpriteNode(imageNamed: card.cardType.spriteName)
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
    fileprivate func extractedFunc(_ lifeLayout: ((Int) -> Void)) {
        lifeLayout(gameViewController.lifeProgress.value)
    }
    
    func updateProgressValues(card: Card){
        if card.cardType == .block || card.cardType == .tacticalPolice{
            gameViewController.energyProgress.updateValue(value: card.value, type: .city)
        }else if card.cardType == .photoRoll || card.cardType == .riotPolice{
            gameViewController.lifeProgress.updateValue(value: card.value, type: .character)
            guard let lifeLayout = lifeLayoutHandler else { return }
            extractedFunc(lifeLayout)
        }
    }
    
    func tryMove(move: Moves) {
        let moveFrom = getCharacterPosition()
        
        let filename = "Level_1"
        
        guard let levelData = LevelData.loadFrom(file: filename) else { return }
        
        guard moveFrom != nil else { return }
        guard let fromCard = level.card(atColumn: moveFrom!.column,
                                        row: moveFrom!.row) else { return }
        
        let energyPhotoValue = levelData.energyPhoto
        let energyRewardValue = levelData.energyReward
        let photoRow = levelData.photoPosition["row"]!
        let photoColumn = levelData.photoPosition["column"]!
        
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
        
        let newCard = level.createNewCard(column: fromCard.column, row: fromCard.row, filename: filename)
        
        let move = MoveCard(cardA: fromCard, cardB: toCard, newCard: newCard)
    
        if let handler = moveHandler {
            if toCard == level.card(atColumn: photoColumn, row: photoRow) && toCard.cardType == .photo{
                if gameViewController.energyProgress.value >= energyPhotoValue {
                    handler(move)
                    canExit = true
                    addReward(playerCard: fromCard, rewardType: .reward1, filename: filename)
                }else{
                    print("Complete a energia da cidade para coletar a foto")
                }
            }else if toCard.cardType == .reward1{
                if gameViewController.energyProgress.value >= energyRewardValue {
                    handler(move)
                    addReward(playerCard: fromCard, rewardType: .reward2, filename: filename)
                    UserDefaultsStruct.Rewards.photoChapter1.gotReward() 
                }else{
                    print("Complete a energia X para coletar a primeira recompensa")
                }
            }else if toCard.cardType == .reward2{
                if gameViewController.energyProgress.value >= energyRewardValue {
                    handler(move)
                    UserDefaultsStruct.Rewards.photoChapter2.gotReward() 
                }else{
                    print("Complete a energia X para coletar a segunda recompensa")
                }
            }else{
                handler(move)
                updateProgressValues(card: toCard)
                print("Energia \(gameViewController.energyProgress.value)")
                if gameViewController.lifeProgress.value == 0{
                    print("Game Over")
                }else{
                    if canExit == true{
                        if level.checkExitPosition(toCard: toCard, filename: filename){
                            print("Venceu")
                        }
                    }
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
    
    func addReward(playerCard: Card, rewardType: CardType, filename: String){
        guard let levelData = LevelData.loadFrom(file: filename) else { return }
        let exitPositions = levelData.exitPosition
        
        let removeCard = SKAction.removeFromParent()
        removeCard.timingMode = .easeOut
        
        let rewardCard = level.createRewardCard(playerColumn: playerCard.column, playerRow: playerCard.row, rewardType: rewardType, exitPositions: exitPositions)
        level.card(atColumn: rewardCard.column, row: rewardCard.row)?.sprite!.run(removeCard)
        level.setReward(reward: rewardCard)
        setSprite(rewardCard)
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


