//
//  IntroductionViewController.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 23/10/20.
//

import UIKit

class IntroductionViewController: UIViewController, UIScrollViewDelegate {

    // MARK: IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var narrativeView: NarrativeIntroView!
    @IBOutlet weak var skipButton: UIButton!
    
    // MARK: Class Variables
    let numberPages: Int = 2
    var pages: [NarrativeIntroView] = []
    
    // MARK: View Cicle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        scrollView.delegate = self
        
        //backgrounds
        view.backgroundColor = AppColor.intermediateBackground.value
        backgroundView.backgroundColor = UIColor(patternImage: UIImage(named: "intro_background")!)
        
        setupScrollView()
    }
    
    // MARK: ScrollView
    func setupScrollView(){
        let contentWidth = backgroundView.bounds.width
        let contentHeight = backgroundView.bounds.height * CGFloat(numberPages)
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int((scrollView.contentOffset.y)/(scrollView.frame.size.height))
                
        switch currentPage {
        case 0:
            narrativeView.imageView.image = UIImage(named: "intro_page1")
        case 1:
            narrativeView.imageView.image = UIImage(named: "intro_page2")
            skipButton.imageView?.image =  UIImage(named: "initialScreen_button")
        default:
            break
        }
    }
    
}
