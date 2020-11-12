//
//  SettingsViewController.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 09/11/20.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var untitledLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    @IBOutlet weak var restartGameButton: UIButton!
    @IBOutlet weak var creditsButton: UIButton!
    @IBOutlet weak var languageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = AppColor.intermediateBackground.value
        titleLabel.textColor = AppColor.lightText.value
        untitledLabel.textColor = AppColor.lightText.value
        versionLabel.textColor = AppColor.lightText.value
        languageButton.setTitleColor(AppColor.intermediateLightText.value, for: .normal)
        restartGameButton.setTitleColor(AppColor.intermediateLightText.value, for: .normal)
        creditsButton.setTitleColor(AppColor.intermediateLightText.value, for: .normal)
    }
    
    @IBAction func backToSettings(segue:UIStoryboardSegue) { }
    
    @IBAction func restartGameTapped(_ sender: Any) {
        
        let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "RestartAlert") as! RestartGameViewController
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(customAlert, animated: true, completion: nil)
    }
}
