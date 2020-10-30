//
//  InitialScreenViewController.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 23/10/20.
//

import UIKit

class InitialScreenViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        backgroundImage.image = UIImage(named: "initialScreen_background")
        self.view.backgroundColor = AppColor.intermediateBackground.value
    }
    
    //View
    func setupViews(){
        //labels
        titleLabel.text = "untitled games"
        subtitleLabel.text = "apresenta:"
    }
    
    

}

