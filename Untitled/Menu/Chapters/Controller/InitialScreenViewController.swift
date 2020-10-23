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

        setupView()
    }
    
    //View
    func setupView(){
        //labels
        titleLabel.text = "untitled games"
        subtitleLabel.text = "apresenta:"
        //background
        backgroundImage.image = UIImage(named: "initialscreen_background")
    }

}
