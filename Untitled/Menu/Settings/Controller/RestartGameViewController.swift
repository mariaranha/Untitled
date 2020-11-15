//
//  RestartGameViewController.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 12/11/20.
//

import UIKit

class RestartGameViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alert_imageView: UIImageView!
    
    var language: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelButton.setTitleColor(AppColor.intermediateLightText.value, for: .normal)
        confirmButton.setTitleColor(AppColor.intermediateLightText.value, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = (AppColor.darkGreyBackground.value).withAlphaComponent(0.9)
        animateView()
        
        language = UserDefaultsStruct.Language.preferLanguage
        confirmButton.setTitle("Confirmar".localized(language), for: .normal)
        cancelButton.setTitle("Cancelar".localized(language), for: .normal)
        alert_imageView.image = UIImage(named: "alertRestart_text".localized(language))
        
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        UserDefaultsStruct.UserLevel.level = 1
        SelectedLevel.value = 1
        self.dismiss(animated: true, completion: nil)
    }
}
