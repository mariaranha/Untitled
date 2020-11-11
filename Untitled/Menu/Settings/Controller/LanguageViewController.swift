//
//  LanguageViewController.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 11/11/20.
//

import UIKit

class LanguageViewController: UIViewController {

    @IBOutlet weak var languageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = AppColor.intermediateBackground.value
        languageLabel.textColor = AppColor.lightText.value
    }

}
