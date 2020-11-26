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
        openButton.setTitleColor(AppColor.intermediateLightText.value, for: .normal)
        let language = UserDefaultsStruct.Language.preferLanguage
        openButton.setTitle("Abrir Álbum".localized(language), for: .normal)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        MusicPlayer.shared.audioPlayer?.play()
    }
    
    @IBAction func backToCloseAlbum(_ sender: UIStoryboardSegue) {
    }

}
