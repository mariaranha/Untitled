//
//  InitialScreenViewController.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 23/10/20.
//

import UIKit

class InitialScreenViewController: UIViewController {
    
    var skipeIntroNarrative: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = AppColor.intermediateBackground.value
        
        skipeIntroNarrative = UserDefaultsStruct.IntroNarrative.skipeIntro
        
        setLanguage()
    }
    
    @IBAction func startPressed(_ sender: Any) {
        if skipeIntroNarrative {
            performSegue(withIdentifier: "skipIntro", sender: nil)
        } else {
            performSegue(withIdentifier: "showIntro", sender: nil)
        }
    }
    
    func setLanguage() {
        var language: String = UserDefaultsStruct.Language.preferLanguage
        
        if language == "" {
            let deviceLanguage = Locale.preferredLanguages[0]
            let appLanguage = NSLocale.current.languageCode
            
            if appLanguage == "" {
                language = deviceLanguage
            } else {
                language = appLanguage ?? "pt_BR"
            }
            
            UserDefaultsStruct.Language.preferLanguage = language
        }
    }
}

