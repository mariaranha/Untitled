//
//  WinGameViewController.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 29/10/20.
//

import UIKit

class WinGameViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var narrativeImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "capítulo finalizado"
        subtitleLabel.text = "#1 - uma história de carnaval"
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "winBackground")!)
        photoImageView.image = UIImage(named: "empty_photo")
        narrativeImageView.image = UIImage(named: "chapter1_win")

    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        //update user defaults
    }
    

}
