//
//  BoardSettingsViewController.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 14/11/20.
//

import UIKit

class BoardSettingsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var tutorialButton: UIButton!
    @IBOutlet weak var exitChapterButton: UIButton!
    
    var language: String!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.textColor = AppColor.highlightText.value
        subtitleLabel.textColor = AppColor.lightText.value
        tutorialButton.setTitleColor(AppColor.intermediateLightText.value, for: .normal)
        exitChapterButton.setTitleColor(AppColor.intermediateLightText.value, for: .normal)
        
        language = UserDefaultsStruct.Language.preferLanguage
        titleLabel.text = SelectedLevel.chapterTitle
        subtitleLabel.text = SelectedLevel.chapterSubtitle
        tutorialButton.setTitle("Ver Tutorial".localized(language), for: .normal)
        exitChapterButton.setTitle("Sair do Capítulo".localized(language), for: .normal)
        
    }

    @IBAction func exitChapterButtonTapped(_ sender: Any) {
        let view = ExitView()
        view.tag = 100
        view.delegate = self
        view.alpha = 0.0
        self.view.addSubview(view)
        view.dismiss = {
            self.performSegue(withIdentifier: "settingsToChaptersMenu", sender: self)
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
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tutorialButtonTapped(_ sender: Any) {
        
        let userLevel = SelectedLevel.level
        
        switch userLevel {
        case 1:
            UserDefaultsStruct.Tutorial.skipChapterOne = false
        case 2:
            UserDefaultsStruct.Tutorial.skipChapterTwo = false
        case 3:
            UserDefaultsStruct.Tutorial.skipChapterThree = false
        default:
            UserDefaultsStruct.Tutorial.skipChapterTwo = false
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
}
