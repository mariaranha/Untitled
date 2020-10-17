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
    
    //Scene draws the sprites and handles swipes
    var scene: GameScene!
    var level: Level!
    
    @IBOutlet weak var progress: UIImageView!
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var life: UIImageView!
    @IBOutlet weak var energy: UIImageView!
    @IBOutlet weak var playerCard: UIImageView!
    @IBOutlet weak var book: UIImageView!
    @IBOutlet weak var cardBoard: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view
        let skView = cardBoard!
        skView.isMultipleTouchEnabled = false
        
        //OBS: Create a singleton to verify the user level and pass here
        level = Level(filename: "Level_1")
        
        // Create and configure the scene
        scene = GameScene(size: skView.bounds.size, level: level)
        scene.backgroundColor = .clear
        scene.scaleMode = .aspectFill
        scene.moveHandler = handleMove
        scene.firstMoveHandler = handleFirstMove

        // Present the scene.
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
