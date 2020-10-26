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
    let numberPages: Int = 3
    var pages: [NarrativeIntroView] = []
    
    // MARK: View Cicle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        scrollView.delegate = self
        
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
        
        backgroundView.backgroundColor = AppColor.intermediateBackground.value
        
        switch currentPage {
        case 0:
            narrativeView.imageView.image = UIImage(named: "intro_page1")
            skipButton.isHidden = false
        case 1:
            narrativeView.imageView.image = UIImage(named: "intro_page1")
            skipButton.isHidden = true
        case 2:
            narrativeView.imageView.image = UIImage(named: "intro_page1")
            skipButton.isHidden = false
        default:
            break
        }
    }
    
}
