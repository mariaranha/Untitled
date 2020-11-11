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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = AppColor.intermediateBackground.value
        creditsLabel.textColor = AppColor.lightText.value
        untitledLabel.textColor = AppColor.lightText.value
        versionLabel.textColor = AppColor.lightText.value
    }

    
}
