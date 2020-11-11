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
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set background
        view.backgroundColor = AppColor.lightBackground.value
        backgroundImage.image = UIImage(named: "rewards_background")
        let language = UserDefaultsStruct.Language.preferLanguage
        openButton.setImage(UIImage(named: "open_album".localized(language)), for: .normal)
    }
    
    @IBAction func backToCloseAlbum(_ sender: UIStoryboardSegue) {
    }

}
