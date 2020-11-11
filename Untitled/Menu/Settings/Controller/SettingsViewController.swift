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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = AppColor.intermediateBackground.value
        titleLabel.textColor = AppColor.lightText.value
        untitledLabel.textColor = AppColor.lightText.value
        versionLabel.textColor = AppColor.lightText.value
            
    }
    
}
