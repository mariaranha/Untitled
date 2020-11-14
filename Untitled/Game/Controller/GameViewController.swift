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
    
    @IBOutlet weak var progressBackground: UIImageView!
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var lifePhoto: UIImageView!
    @IBOutlet weak var totalLifeLabel: UILabel!
    @IBOutlet weak var currentLifeLabel: UILabel!
    @IBOutlet weak var energy: UIImageView!
    @IBOutlet weak var cityPhoto: UIImageView!
    @IBOutlet weak var cardBoard: SKView!
    @IBOutlet weak var energyStack: UIStackView!
    @IBOutlet weak var photoReward: UIImageView!
    @IBOutlet weak var firstReward: UIImageView!
    @IBOutlet weak var secondReward: UIImageView!
    @IBOutlet weak var costumePhoto: UIImageView!
    @IBOutlet weak var boardHeight: NSLayoutConstraint!
    @IBOutlet weak var boardWidth: NSLayoutConstraint!
    
    //Scene draws the sprites and handles gestures
    var scene: GameScene!
    var level: Level!
    var currentLevel: Int = 0
    
    var tileWidth: CGFloat = 0.0
    var tileHeight: CGFloat = 0.0
    
    let cardAspectRatio: CGFloat = 1.38
    
    var energyProgress: Life = Life(type: .city)
    var lifeProgress: Life  =  Life(type: .character)
    
    var dismissNarrative : (() -> Void)?
    var restartNarrative : (() -> Void)?
    
    var language: String = ""
    
    //Tutorial view
    let tutorialPage: UIView = {
        let view = UIView()
        
        view.frame = UIScreen.main.bounds
        view.backgroundColor = .black
        view.alpha = 0.8
        
        return view
    }()
    
    let tapView: UIView = {
        let view = UIView()
        
        view.frame = UIScreen.main.bounds
        view.backgroundColor = .clear
        
        return view
    }()
    
    let tutorialImageView = UIImageView()
    
    let continueTutorialLabel = UILabel()
    
    let albumView = UIView()
    
    var currentTutorialPage: Int = 1
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view
        let skView = cardBoard!
        skView.isMultipleTouchEnabled = false
        
        level = Level(filename: "Level_\(currentLevel)")
        
        // Configure View
        setInitialLifeLayout()
        setInitialEnergyLayout()
        setInitialRewardsLayout()
        costumePhoto.image = UIImage(named: "")
        
        // Create and configure the scene
        view.layoutSubviews()
        let size = getBoardSize(forLevel: level)
        boardWidth.constant = size.width
        boardHeight.constant = size.height
        scene = GameScene(gameViewController: self, size: size, level: level, tileSize: .init(width: tileWidth, height: tileHeight))
        scene.backgroundColor = .clear
        scene.scaleMode = .aspectFill
        scene.addTiles()
        scene.moveHandler = handleMove
        scene.lifeLayoutHandler = updateLifeValue(_:)
        scene.energyLayoutHandler = updateEnergyValue(_:)
        scene.rewardLayoutHandler = updateRewards(_:_:_:)

        // Present the scene
        skView.presentScene(scene)

        beginGame()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        language = UserDefaultsStruct.Language.preferLanguage
        currentTutorialPage = 1
        
        setUpTutorial()
    }
    
    func setInitialLifeLayout() {
        totalLifeLabel.textColor = AppColor.lightText.value
        currentLifeLabel.textColor = AppColor.lightText.value
        
        if lifeProgress.value < 10 {
            totalLifeLabel.text = "0\(String(lifeProgress.value))"
            currentLifeLabel.text = "0\(String(lifeProgress.value))"
        } else {
            totalLifeLabel.text = String(lifeProgress.value)
            currentLifeLabel.text = String(lifeProgress.value)
        }
    }
    
    func setInitialEnergyLayout() {
        guard let energyBars = energyStack.subviews as? [UIImageView] else { return }
        let energyValue = energyProgress.value
        
        for bar in energyBars {
            if bar.tag > energyValue {
                bar.image = UIImage(named: "energy_bar_empty")
            } else {
                bar.image = UIImage(named: "energy_bar_full")
            }
        }
    }
    
    func setInitialRewardsLayout() {
        photoReward.image = UIImage(named: "board_empty_reward")
        firstReward.image = UIImage(named: "board_empty_reward")
        secondReward.image = UIImage(named: "board_empty_reward")
    }
    
    func updateEnergyValue(_ value: Int) {
        guard let energyBars = energyStack.subviews as? [UIImageView] else { return }
        
        for bar in energyBars {
            if bar.tag > value {
                bar.image = UIImage(named: "energy_bar_empty")
            } else {
                bar.image = UIImage(named: "energy_bar_full")
            }
        }
    }
    
    func updateLifeValue(_ value: Int) {
        if value < 10 {
            currentLifeLabel.text = "0\(String(value))"
        } else {
            currentLifeLabel.text = String(value)
        }
    
    }
    
    //Note: need to update assets
    func updateRewards(_ gotPhoto: Bool, _ gotFirstReward: Bool, _ gotSecondReward: Bool) {
        //PHOTO
        if gotPhoto {
            photoReward.image = UIImage(named: "board_collected_reward_\(currentLevel)")
        } else {
            photoReward.image = UIImage(named: "board_empty_reward")
        }
        
        //FIRST REWARD
        if gotFirstReward {
            firstReward.image = UIImage(named: "board_collected_reward_\(currentLevel)")
        } else {
            firstReward.image = UIImage(named: "board_empty_reward")
        }
        
        //SECOND REWARD
        if gotSecondReward {
            secondReward.image = UIImage(named: "board_collected_reward_\(currentLevel)")
        } else {
            secondReward.image = UIImage(named: "board_empty_reward")
        }
    }
    
    func beginGame() {
        let newCards = level.createInitialCards(filename: "Level_\(currentLevel)")
        scene.addInitialSprites(for: newCards)
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

        let topSpace = progressBackground.frame.maxY + 16
        let bottomSpace = screenSize.height - lifePhoto.frame.minY + 20
        let sideSpace: CGFloat = 20.0
        
        let boardSafeHeight = topSpace + bottomSpace
        let boardSafeWidth = 2 * sideSpace
        
        let availableWidth = screenSize.width - boardSafeWidth
        let availableHeight = screenSize.height - boardSafeHeight
        
        let numRows = CGFloat(level.numRows)
        let numCols = CGFloat(level.numColumns)
        
        tileWidth = availableWidth / numCols
        tileHeight = tileWidth * cardAspectRatio
    
        if tileHeight * numRows > availableHeight {
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
    
    @IBAction func exitGame(_ sender: Any) {
        let view = ExitView()
        view.tag = 100
        view.delegate = self
        view.alpha = 0.0
        self.view.addSubview(view)
        view.dismiss = {
            self.dismiss(animated: true, completion: nil)
            self.dismissNarrative?()
        }
        view.cancel = {
            UIView.animate(withDuration: 0.5, animations: {
                view.alpha = 0.0
            }) { (completion) in
                view.removeFromSuperview()
            }
        }
        UIView.animate(withDuration: 0.5, animations: {
            view.alpha = 1.0
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WinGameViewController {
            vc.dismissFunc = {
                self.dismiss(animated: false) {
                    self.dismissNarrative?()
                }
            }
        }
        if let vc = segue.destination as? GameOverViewController {
            vc.dismissFunc = {
                self.dismiss(animated: false) {
                    self.dismissNarrative?()
                }
            }
            vc.restartFunc = {
                self.dismiss(animated: false) {
                    self.restartNarrative?()
                }
            }
        }
    }
}
