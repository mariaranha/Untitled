//
//  CreditsViewController.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 10/11/20.
//

import UIKit

class CreditsViewController: UIViewController {

    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var untitledLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var creditsImageView: UIImageView!
    
    var language: String!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        language = UserDefaultsStruct.Language.preferLanguage
        creditsLabel.text = "créditos do jogo".localized(language)
        versionLabel.text = "versão 1.0.1".localized(language)
        creditsImageView.image = UIImage(named: "credits_text".localized(language))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = AppColor.intermediateBackground.value
        creditsLabel.textColor = AppColor.lightText.value
        untitledLabel.textColor = AppColor.lightText.value
        versionLabel.textColor = AppColor.lightText.value
    }

    
}
