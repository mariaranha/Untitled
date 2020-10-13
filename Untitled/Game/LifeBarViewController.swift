//
//  LifeBarViewController.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 12/10/20.
//

import UIKit
import SpriteKit

class LifeBarViewController: UIViewController {

    @IBOutlet weak var progressBar: ProgressBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        var progress = 0.5
        progressBar.progress = CGFloat(progress)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            progress = 1.0
            self.progressBar.progress = CGFloat(progress)
        }
        
    }


}
