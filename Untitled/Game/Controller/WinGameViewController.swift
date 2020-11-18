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
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "winBackground")!)
        titleLabel.text = "capítulo finalizado".localized(language)
        photoImageView.image = UIImage(named: "empty_photo")
        
        subtitleLabel.text = "#1 - uma história de carnaval".localized(language)
        narrativeImageView.image = UIImage(named: "chapter1_win".localized(language))
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        //update user defaults
        self.dismiss(animated: true, completion: nil)
        self.dismissFunc?()
    }
    

}
