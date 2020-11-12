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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelButton.setTitleColor(AppColor.intermediateLightText.value, for: .normal)
        confirmButton.setTitleColor(AppColor.intermediateLightText.value, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = (AppColor.darkGreyBackground.value).withAlphaComponent(0.9)
        animateView()
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
        self.dismiss(animated: true, completion: nil)
    }
}
