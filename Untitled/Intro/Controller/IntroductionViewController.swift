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
    @IBOutlet weak var narrativeView: NarrativeIntroView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var introLogo: UIImageView!
    @IBOutlet weak var swipeToRead: UILabel!
    
    // MARK: Class Variables
    let numberPages: Int = 2
    var narratives: [NarrativeIntroView] = []
    var pageIndex: Int = 0
    
    var narrativeOrigin: CGPoint!
    
    // MARK: View Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
    
        view.backgroundColor = AppColor.intermediateBackground.value
        narrativeOrigin = narrativeView.frame.origin
        
        swipeToRead.text = "deslize para ler"
        swipeToRead.textColor = AppColor.lightText.value
        skipButton.isHidden = true

        view.layoutIfNeeded()
        view.layoutSubviews()
        narratives = createNarratives()
        setupScrollView(narratives: narratives)
    }
    
    //MARK: Narratives
    func createNarratives() -> [NarrativeIntroView] {
        for narrativeNumber in 1...numberPages {
            let narrative: NarrativeIntroView = Bundle.main.loadNibNamed("NarrativeIntroView", owner: self, options: nil)?.first as! NarrativeIntroView
            
            narrative.imageView.image = UIImage(named: "intro_page\(narrativeNumber)")
            
            narratives.append(narrative)
        }
        
        return narratives
    }
    
    // MARK: ScrollView
    func setupScrollView(narratives: [NarrativeIntroView]) {
        let screenWidth = UIScreen.main.bounds.width
        let scrollHeight = -introLogo.frame.maxY + skipButton.frame.minY
        
        scrollView.frame = CGRect(x: 0, y: introLogo.frame.maxY, width: screenWidth, height: scrollHeight)
        scrollView.contentSize = CGSize(width: screenWidth, height: scrollHeight * CGFloat(numberPages))
        scrollView.isPagingEnabled = true
        
        let narrativeFrame = narrativeView.frame
        
        for i in 0 ..< narratives.count {
            narratives[i].frame = CGRect(x: narrativeOrigin.x,
                                         y: narrativeOrigin.y + scrollHeight  * CGFloat(i),
                                         width: narrativeFrame.width,
                                         height: narrativeFrame.height)
            scrollView.addSubview(narratives[i])
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPageIndex = floor(scrollView.contentOffset.y/scrollView.frame.height)
        
        pageIndex = Int(scrollPageIndex)
        
        print(pageIndex)
        
        if pageIndex <= 0 {
            skipButton.isHidden = true
            swipeToRead.isHidden = false
        } else {
            skipButton.isHidden = false
            swipeToRead.isHidden = true
        }
    }
    
}
