//
//  GameViewController.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 07/10/20.
//

import UIKit
import SpriteKit
import AVFoundation

class GameViewController: UIViewController {
    
    @IBOutlet weak var progress: UIImageView!
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var life: UIImageView!
    @IBOutlet weak var energy: UIImageView!
    @IBOutlet weak var playerCard: UIImageView!
    @IBOutlet weak var album: UIImageView!
    @IBOutlet weak var cardBoard: SKView!
    @IBOutlet weak var boardHeight: NSLayoutConstraint!
    @IBOutlet weak var boardWidth: NSLayoutConstraint!
    
    //Scene draws the sprites and handles gestures
    var scene: GameScene!
    var level: Level!
    
    var tileWidth: CGFloat = 0.0
    var tileHeight: CGFloat = 0.0
    
    let cardAspectRatio: CGFloat = 1.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view
        let skView = cardBoard!
        skView.isMultipleTouchEnabled = false
        
        //Note: Create a singleton to verify the user level and pass here
        level = Level(filename: "Level_1")
        
        // Create and configure the scene
        view.layoutSubviews()
        let size = getBoardSize(forLevel: level)
        boardWidth.constant = size.width
        boardHeight.constant = size.height
        scene = GameScene(size: size, level: level, tileSize: .init(width: tileWidth, height: tileHeight))
        scene.backgroundColor = .clear
        scene.scaleMode = .aspectFill
        scene.moveHandler = handleMove
        scene.firstMoveHandler = handleFirstMove

        // Present the scene
        skView.presentScene(scene)

        beginGame()
    }
    
    func beginGame() {
        let newCards = level.createInitialCards()
        scene.addInitialSprites(for: newCards)
    }
    
    func handleFirstMove(_ move: FirstMove) {
        view.isUserInteractionEnabled = false
        
        playerCard.removeFromSuperview()
        level.performFirstMove(move)
        scene.animateFirstMove(move)
        self.view.isUserInteractionEnabled = true
    }
    
    func handleMove(_ move: MoveCard) {
        view.isUserInteractionEnabled = false
        
        level.performMove(move)
        scene.animateMove(move) {
            self.view.isUserInteractionEnabled = true
        }
        
    }
    
    func getBoardSize(forLevel level: Level) -> CGSize {
        let screenSize = UIScreen.main.bounds

        let topSpace = album.frame.maxY + 8
        let bottomSpace = screenSize.height - life.frame.minY + 8
        let sideSpace: CGFloat = 18.0
        
        let boardSafeHeight = topSpace + bottomSpace
        let boardSafeWidth = 2 * sideSpace
        
        let availableWidth = screenSize.width - boardSafeWidth
        let availableHeight = screenSize.height - boardSafeHeight
        
        let numRows = CGFloat(level.numRows)
        let numCols = CGFloat(level.numColumns)
        
        tileWidth = availableWidth / numCols
        tileHeight = tileWidth * cardAspectRatio
    
        if cardAspectRatio * tileWidth * numRows > availableHeight {
            tileHeight = availableHeight / numRows
            tileWidth = tileHeight / cardAspectRatio
        }
        
        return CGSize(width: tileWidth * numCols, height: tileHeight * numRows)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait]
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
