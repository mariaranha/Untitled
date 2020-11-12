//
//  LanguageViewController.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 11/11/20.
//

import UIKit

class LanguageViewController: UIViewController {

    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var portugueseButton: UIButton!
    @IBOutlet weak var englishButton: UIButton!
    
    var buttons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = AppColor.intermediateBackground.value
        languageLabel.textColor = AppColor.lightText.value
        portugueseButton.setTitleColor(AppColor.intermediateLightText.value, for: .normal)
        englishButton.setTitleColor(AppColor.intermediateLightText.value, for: .normal)
        
        portugueseButton.addTarget(self, action: #selector(buttonPressed), for: UIControl.Event.touchUpInside)
        englishButton.addTarget(self, action: #selector(buttonPressed), for: UIControl.Event.touchUpInside)
        
        buttons = [portugueseButton, englishButton]
        
    }
    
    
    @objc func buttonPressed(_ sender: UIButton) {
        
        buttons.forEach { $0.isSelected = false }

        if !sender.isSelected {
            sender.setBackgroundImage(UIImage(named: "backgroundHighlighted_button"), for: .selected)
            sender.setBackgroundImage(UIImage(named: "backgroundHighlighted_button"), for: .highlighted)
            sender.isSelected = true
        }
        
        if portugueseButton.isSelected{
            print("Update user default to portuguese here")
        }
        
        if englishButton.isSelected{
            print("Update user default to english here")
        }
    }


}
