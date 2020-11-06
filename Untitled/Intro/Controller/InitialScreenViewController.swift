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
    }
    
    @IBAction func startPressed(_ sender: Any) {
        if skipeIntroNarrative {
            performSegue(withIdentifier: "skipIntro", sender: nil)
        } else {
            performSegue(withIdentifier: "showIntro", sender: nil)
        }
    }
}

