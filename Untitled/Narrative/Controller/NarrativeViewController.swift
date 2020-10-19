//
//  NarrativeViewController.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 17/10/20.
//

import UIKit

class NarrativeViewController: UIViewController {

    @IBOutlet weak var narrativeView: NarrativeView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var pages: [NarrativeView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup view
        self.view.backgroundColor = AppColor.lightBackground.value
//        narrativeView.contentView.backgroundColor = AppColor.lightBackground.value
//        narrativeTitleView.titleLabel.text = "capítulo um"
//        narrativeTitleView.titleLabel.textColor = AppColor.intermediateLightText.value
//        narrativeTitleView.subtitleLabel.text = "uma história de carnaval"
//        narrativeTitleView.imageView.image = UIImage(named: "narrative_star")
    }
    
//    func createPages() -> [NarrativeView] {
//        
//        
//    }
    

    

}
