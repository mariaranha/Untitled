//
//  GameOverViewController.swift
//  Untitled
//
//  Created by Inara Takashi on 08/11/20.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var narrativeImageView: UIImageView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "memória perdida"
        titleLabel.font = UIFont(name: "Lalezar-Regular", size: 40)
        subtitleLabel.text = "1. uma história de carnaval"
        subtitleLabel.font = UIFont(name: "Lalezar-Regular", size: 20)
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "gameOverBackground")!)
        photoImageView.image = UIImage(named: "empty_photo")
        narrativeImageView.image = UIImage(named: "chapter1_gameOver")
    }
    

    @IBAction func restartBtn(_ sender: Any) {
    }
    
}