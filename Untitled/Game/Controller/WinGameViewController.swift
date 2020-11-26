//
//  WinGameViewController.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 29/10/20.
//

import UIKit

class WinGameViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var narrativeImageView: UIImageView!
    
    var dismissFunc : (() -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
    }
    
    func setLayout() {
        let language = UserDefaultsStruct.Language.preferLanguage
        let selectedChapter = SelectedLevel.level
        let chapterSubtitle = SelectedLevel.chapterSubtitle
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "winBackground")!)
        titleLabel.text = "capítulo finalizado".localized(language)
        photoImageView.image = UIImage(named: "win_photo_\(selectedChapter)")
        narrativeImageView.image = UIImage(named: "chapter\(selectedChapter)_win".localized(language))
        subtitleLabel.text = "\(selectedChapter). \(chapterSubtitle)"
        
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        //update user defaults
        self.dismiss(animated: true, completion: nil)
        self.dismissFunc?()
        
        MusicPlayer.shared.stopBackgroundMusic()
        MusicPlayer.shared.startBackgroundMusic(backgroundMusicFileName: "maracatu-menu-capitulos")
        
        SelectedLevel.level += 1
    }
    

}
