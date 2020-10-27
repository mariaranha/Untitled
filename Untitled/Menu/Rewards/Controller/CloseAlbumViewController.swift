//
//  RewardsViewController.swift
//  Untitled
//
//  Created by Julia Conti Mestre on 22/10/20.
//

import UIKit

class CloseAlbumViewController: UIViewController {
    
    @IBOutlet weak var openAlbumButton: UIButton!
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColor.lightBackground.value
        
        //Set Open Album button
        openButton.layer.borderWidth = 3.0
        openButton.layer.borderColor = AppColor.intermediateBorder.value.cgColor
        openButton.setTitleColor(AppColor.intermediateLightText.value, for: .normal)
        openButton.setTitle("Abrir", for: .normal)
        
        //Set Back butotn
        backButton.setTitle("Voltar", for: .normal)
    }
    
    @IBAction func backToCloseAlbum(_ sender: UIStoryboardSegue) {
    }

}
