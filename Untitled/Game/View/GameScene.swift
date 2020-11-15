//
//  GameScene.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 07/10/20.
//

import SpriteKit
import GameplayKit
import UIKit

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
    var rewardLayoutHandler: ((Bool, Bool, Bool) -> Void)?
    
    var gameViewController:GameViewController!
    
    var canExit = false
    var gotRewar1 = false
    var gotRewar2 = false
    
    var round: Int = 0
    
    enum Moves {
        case up
        case down
        case right
        case left
        case center
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
  
    init(gameViewController: GameViewController, size: CGSize, level: Level, tileSize: CGSize) {
        self.gameViewController = gameViewController
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
        
        let cardCenter = (point: pointFor(column: characterPosition.column,
                                         row: characterPosition.row),
                        move: Moves.center)
        
        let possibleCards = [cardUp, cardDown, cardRight, cardLeft, cardCenter]
        
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
    
    func updateProgressValues(card: Card){
        if card.cardType == .block || card.cardType == .tacticalPolice{
            gameViewController.energyProgress.updateValue(value: card.value, type: .city)
            guard let energyLayout = energyLayoutHandler else { return }
            energyLayout(gameViewController.energyProgress.value)
        }else if card.cardType == .photoRoll || card.cardType == .riotPolice{
            gameViewController.lifeProgress.updateValue(value: card.value, type: .character)
            guard let lifeLayout = lifeLayoutHandler else { return }
            lifeLayout(gameViewController.lifeProgress.value)
        }
    }
    
    func goToScreen(storyboard: String, viewController: String){
        let storyBoard = UIStoryboard(name: storyboard, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: viewController)
        vc.view.layoutIfNeeded()

        UIView.transition(with: self.view!, duration: 0.0, options: .transitionFlipFromRight, animations:
                {
                    self.view?.window?.rootViewController = vc
            }, completion: { completed in
                // maybe do something here
            })
    }
    
    // MARK: Move
    func tryMove(move: Moves) {
        
        let moveFrom = getCharacterPosition()
        
        let filename = "Level_\(gameViewController.currentLevel)"
        
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
        case .center:
            moveTo?.row = -1
        }
        
        guard let toCard = level.card(atColumn: moveTo!.column, row: moveTo!.row) else {
            if moveTo?.row == -1 && canExit == true && (move == .down || move == .center){
                if level.checkExitPosition(toCard: fromCard, filename: filename) {
                    gotReward(gotReward1: gotRewar1, gotReward2: gotRewar2)
                    print("Venceu")
                    let view = WinRewardsView()
                    view.alpha = 0.0
                    self.gameViewController.view.addSubview(view)
                    
                    if gotRewar1 { view.rewardsImages.append(UIImage(named: "board_collected_reward_1.png")) }
                    if gotRewar2 { view.rewardsImages.append(UIImage(named: "board_collected_reward_1.png")) }
                    
                    view.delegate = self.gameViewController
                    view.continueFunc = {
                        self.gameViewController.performSegue(withIdentifier: "goToWinGame", sender: self.gameViewController)
                    }
                    UIView.animate(withDuration: 0.5, animations: {
                        view.alpha = 1.0
                    })
                }
            }
            return
        }
        
        let newCard = level.createNewCard(column: fromCard.column, row: fromCard.row, filename: filename)
        
        let moveCard = MoveCard(cardA: fromCard, cardB: toCard, newCard: newCard)
    
        if let handler = moveHandler {
            if toCard == level.card(atColumn: photoColumn, row: photoRow) && toCard.cardType == .photo{
                if gameViewController.energyProgress.value >= energyPhotoValue {
                    handler(moveCard)
                    round += 1
                    canExit = true
                    
                    addReward(playerCard: fromCard, rewardType: .reward1, filename: filename)
                    //Add photo to progress bar
                    guard let rewardHandler = rewardLayoutHandler else { return }
                    rewardHandler(true, false, false)
                    
                    setConservator(characterCard: toCard)
                }else{
                    print("Complete a energia da cidade para coletar a foto")
                }
            }else if toCard.cardType == .reward1{
                if gameViewController.energyProgress.value >= energyRewardValue {
                    handler(moveCard)
                    round += 1
                    
                    addReward(playerCard: fromCard, rewardType: .reward2, filename: filename)
                    gotRewar1 = true
                    //Add reward1 to progress bar
                    guard let rewardHandler = rewardLayoutHandler else { return }
                    rewardHandler(true, true, false)
                    
                    setConservator(characterCard: toCard)
                }else{
                    print("Complete a energia X para coletar a primeira recompensa")
                }
            }else if toCard.cardType == .reward2{
                if gameViewController.energyProgress.value >= energyRewardValue {
                    handler(moveCard)
                    round += 1
                    
                    gotRewar2 = true
                    //Add reward2 to progress bar
                    guard let rewardHandler = rewardLayoutHandler else { return }
                    rewardHandler(true, true, true)
                    
                    setConservator(characterCard: toCard)
                }else{
                    print("Complete a energia X para coletar a segunda recompensa")
                }
            }else{
                handler(moveCard)
                round += 1
                updateProgressValues(card: toCard)
                setConservator(characterCard: toCard)
                
                if gameViewController.lifeProgress.value == 0{
                    print("Game Over")
                    self.gameViewController.performSegue(withIdentifier: "goToGameOver", sender: self)
//                    goToScreen(storyboard: "GameOver", viewController: "GameOverViewController")
                }
            }
        }
    }
    
    func setConservator(characterCard: Card){
        guard let levelData = LevelData.loadFrom(file: "Level_\(gameViewController.currentLevel)") else { return }
        if round % levelData.roundConservator == 0 && levelData.hasConservator == true {
            let removeCard = SKAction.removeFromParent()
            removeCard.timingMode = .easeOut

            if let conservatorPosition = getConservatorPosition(){
                let newPositionConservator = conservatorNewPosition(currentPosition: conservatorPosition)
                
                var cardNew = level.createNewCard(column: conservatorPosition.column, row: conservatorPosition.row, filename: "Level_\(gameViewController.currentLevel)")
                while cardNew.cardType == .photoRoll || cardNew.cardType == .block{
                    cardNew = level.createNewCard(column: conservatorPosition.column, row: conservatorPosition.row, filename: "Level_\(gameViewController.currentLevel)")
                }

                let moveCard = MoveCard(cardA: level.card(atColumn: conservatorPosition.column, row: conservatorPosition.row)!, cardB: level.card(atColumn: newPositionConservator.column, row: newPositionConservator.row)!, newCard: cardNew)
                if let handler = moveHandler{
                    handler(moveCard)
                }
                
            }else{
                let positionConservator = conservatorPosition(characterPosition: characterCard)
                let conservatorCard = Card(column: positionConservator.column, row: positionConservator.row, cardType: .conservator, value: 0)
                
                level.card(atColumn: positionConservator.column, row: positionConservator.row)?.sprite!.run(removeCard)
                level.setCard(newCard: conservatorCard)
                setSprite(conservatorCard)
            }
            
        }
    }
    
    func conservatorPosition(characterPosition: Card) -> (column: Int, row: Int){
        var positionConservator = (column: 0, row: 0)
        let elementsColumn: [Int] = [0,4]
        var enemyCards: [Card] = []
        var lifeCards: [Card] = []
        var randomCard: Card
        
        if characterPosition.column == 2{
            positionConservator.column = elementsColumn.randomElement()!
        } else if characterPosition.column < 2{
            positionConservator.column = characterPosition.column + 2
        } else {
            positionConservator.column = characterPosition.column - 2
        }
        
        let cards = [level.card(atColumn: positionConservator.column, row: 0),
                     level.card(atColumn: positionConservator.column, row: 1),
                     level.card(atColumn: positionConservator.column, row: 2),
                     level.card(atColumn: positionConservator.column, row: 3),
                     level.card(atColumn: positionConservator.column, row: 4)]
        
        for card in cards {
            if (card!.cardType == .block || card!.cardType == .photoRoll) && card!.row != characterPosition.row{
                lifeCards.append(card!)
            }else if (card!.cardType == .tacticalPolice || card!.cardType == .riotPolice) && card!.row != characterPosition.row{
                enemyCards.append(card!)
            }
        }
        
        if lifeCards.count != 0{
            randomCard = lifeCards.randomElement()!
            positionConservator.row = randomCard.row
        }else{
            randomCard = enemyCards.randomElement()!
            positionConservator.column = randomCard.column
        }
        
        return positionConservator
    }
    
    func conservatorNewPosition(currentPosition: (column: Int, row: Int)) -> (column: Int, row: Int){
        var enemyCards: [Card] = []
        var lifeCards: [Card] = []
        var cards: [Card] = []
        var positionConservator = (column: 0, row: 0)
        var randomCard: Card
        
        if let cardUp = level.card(atColumn: currentPosition.column, row: currentPosition.row + 1){
            cards.append(cardUp)
        }
        if let cardDown = level.card(atColumn: currentPosition.column, row: currentPosition.row - 1){
            cards.append(cardDown)
        }
        if let cardRight = level.card(atColumn: currentPosition.column + 1, row: currentPosition.row){
            cards.append(cardRight)
        }
        if let cardLeft = level.card(atColumn: currentPosition.column - 1, row: currentPosition.row){
            cards.append(cardLeft)
        }
        
        for card in cards {
            if card.cardType == .block || card.cardType == .photoRoll{
                lifeCards.append(card)
            }else if card.cardType == .tacticalPolice || card.cardType == .riotPolice{
                enemyCards.append(card)
            }
        }
        
        if lifeCards.count != 0{
            randomCard = lifeCards.randomElement()!
            positionConservator.column = randomCard.column
            positionConservator.row = randomCard.row
        }else{
            randomCard = enemyCards.randomElement()!
            positionConservator.column = randomCard.column
            positionConservator.row = randomCard.row
        }
        
        return positionConservator
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
    
    fileprivate func getConservatorPosition() -> (column: Int, row: Int)? {
        var position = (column: 0, row: 0)
        let numColumns = level.numColumns
        let numRows = level.numRows
        
        for row in 0..<numRows {
            for column in 0..<numColumns {
                let card = level.card(atColumn: column, row: row)
                if card?.cardType == CardType.conservator {
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
        level.setCard(newCard: rewardCard)
        setSprite(rewardCard)
    }
    
    func gotReward(gotReward1: Bool, gotReward2: Bool){
        if gotReward1{
            UserDefaultsStruct.Rewards.photoChapter1.gotReward()
        }
        if gotReward2{
            UserDefaultsStruct.Rewards.photoChapter2.gotReward()
        }
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


