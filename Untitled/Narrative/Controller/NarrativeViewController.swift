//
//  NarrativeViewController.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 17/10/20.
//

import UIKit

class NarrativeViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: IBOutlets
    @IBOutlet weak var narrativeView: NarrativeView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var narrativeSlide: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    // MARK: Class Variables
    var numPages: Int = 5
    var pages: [NarrativeView] = []
    var pageIndex: Int = 0
    
    
    // MARK: View Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        //setup view
        self.view.backgroundColor = AppColor.lightBackground.value
//        narrativeView.contentView.backgroundColor = AppColor.lightBackground.value
//        narrativeTitleView.titleLabel.text = "capítulo um"
//        narrativeTitleView.titleLabel.textColor = AppColor.intermediateLightText.value
//        narrativeTitleView.subtitleLabel.text = "uma história de carnaval"
//        narrativeTitleView.imageView.image = UIImage(named: "narrative_star")
        
        //Setup pages
        pageIndex = 0
//        pages = createPages()
        setupPageScrollView(pages: pages)
    }
    
//    func createPages() -> [NarrativeView] {
//
//        for pageNumber in 0...numPages {
//            let page: NarrativeView = Bundle.main.loadNibNamed("NarrativeView", owner: self, options: nil)?.first as! NarrativeView
//
//            switch pageNumber {
//            case 0:
//                page.backgroundColor = AppColor.darkBackground.value
//            case 1:
//                page.backgroundColor = AppColor.darkBackground.value
//            case 2:
//                page.backgroundColor = AppColor.lightBackground.value
//            case 3:
//                page.backgroundColor = AppColor.darkBackground.value
//            default:
//                break
//            }
//
//            pages.append(page)
//        }
//
//        return pages
//    }
    
    // MARK: ScrollView
    func setupPageScrollView(pages: [NarrativeView]){
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        scrollView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight * CGFloat(numPages))
        scrollView.isPagingEnabled = true
//        scrollView.showsVerticalScrollIndicator = false

        
//        view.layoutSubviews()
//        for i in 0 ..< pages.count {
//            pages[i].frame = CGRect(x: narrativeView.frame.width * CGFloat(i),
//                                       y: narrativeView.frame.minY,
//                                       width: narrativeView.frame.width,
//                                       height: narrativeView.frame.height)
//
//
//            scrollView.addSubview(pages[i])
//        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPageIndex = floor(scrollView.contentOffset.y/view.frame.width) + 1
        print(scrollPageIndex)
        let direction = scrollView.panGestureRecognizer.translation(in: scrollView.superview).y
        
        switch scrollPageIndex {
        case 0:
            narrativeView.backgroundColor = AppColor.lightBackground.value
            playButton.isHidden = true
        case 3:
            narrativeView.backgroundColor = AppColor.darkBackground.value
            narrativeSlide.isHidden = true
            playButton.isHidden = true
        case 5:
            narrativeView.backgroundColor = AppColor.lightBackground.value
            narrativeSlide.isHidden = true
            playButton.isHidden = true
        case 7:
            narrativeView.backgroundColor = AppColor.darkBackground.value
            narrativeSlide.isHidden = true
            playButton.isHidden = true
        case 9:
            narrativeView.backgroundColor = AppColor.lightBackground.value
            narrativeSlide.isHidden = true
            playButton.isHidden = false
        default:
            break
        }
        
    }
    

}
