//
//  InitialScreenViewController.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 23/10/20.
//

import UIKit

class InitialScreenViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var logo: UIImageView!
    
    var skipeIntroNarrative: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = AppColor.intermediateBackground.value
        startButton.setTitleColor(AppColor.intermediateLightText.value, for: .normal)
        
        skipeIntroNarrative = UserDefaultsStruct.IntroNarrative.skipeIntro
        
        setLanguage()
        let language = UserDefaultsStruct.Language.preferLanguage
        startButton.setTitle("Entrar".localized(language), for: .normal)
        logo.image = UIImage(named: "initialScreen_logo".localized(language))
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
                language = appLanguage ?? Languages.english.rawValue
            }
            
            if language != Languages.portuguese.rawValue && language != Languages.portugueseDevice.rawValue && language != Languages.english.rawValue {
                language = Languages.english.rawValue
            }
            
            if language == Languages.portugueseDevice.rawValue {
                language = Languages.portuguese.rawValue
            }
            
            UserDefaultsStruct.Language.preferLanguage = language
        }
    }
}

extension String {
func localized(_ lang: String) -> String {

    let path = Bundle.main.path(forResource: lang, ofType: "lproj")
    let bundle = Bundle(path: path!)

    return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
}}
