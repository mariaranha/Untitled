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
    @IBOutlet weak var restartButton: UIButton!
    
    var restartFunc : (() -> Void)?
    var dismissFunc : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
    }
    
    func setLayout() {
        let selectedChapter = SelectedLevel.level
        let language = UserDefaultsStruct.Language.preferLanguage
        let chapterSubtitle = SelectedLevel.chapterSubtitle
        
        titleLabel.font = UIFont(name: "Lalezar-Regular", size: 40)
        subtitleLabel.font = UIFont(name: "Lalezar-Regular", size: 20)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "gameOverBackground")!)
        photoImageView.image = UIImage(named: "gameOver_photo")
        narrativeImageView.image = UIImage(named: "chapter_gameOver".localized(language))
        titleLabel.text = "memória perdida".localized(language)
        restartButton.setImage(UIImage(named: "restart_button".localized(language)), for: .normal)
        subtitleLabel.text = "\(selectedChapter). \(chapterSubtitle)"
    }
    

    @IBAction func restartBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.restartFunc?()
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.dismissFunc?()
    }
}
