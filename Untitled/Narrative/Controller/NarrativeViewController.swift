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
    @IBOutlet weak var indexPageStackView: UIStackView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    var labels: [UILabel] = []
    
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
        
        //Setup pages
        pageIndex = 0
//        pages = createPages()
        setupPageScrollView(pages: pages)
        labels  = [label1, label2, label3, label4, label5]
//        narrativeView = Bundle.main.loadNibNamed("NarrativeView", owner: self, options: nil)?.first as! NarrativeView
    }
    
    // MARK: ScrollView
    func setupPageScrollView(pages: [NarrativeView]){
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        scrollView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight * CGFloat(numPages))
        scrollView.isPagingEnabled = true

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPageIndex = floor(scrollView.contentOffset.y/view.frame.width) + 1
        let direction = scrollView.panGestureRecognizer.translation(in: scrollView.superview).y
        
        switch scrollPageIndex {
        case 0:
            narrativeView.backgroundColor = AppColor.lightBackground.value
            playButton.isHidden = true
            narrativeSlide.isHidden = false
            setLabels()
            label1.text = "- I"
            label1.font = UIFont.boldSystemFont(ofSize: 20.0)
            narrativeView.imageView.image = UIImage(named: "chapter1_01")
        case 3:
            narrativeView.backgroundColor = AppColor.lightBackground.value
            narrativeSlide.isHidden = true
            playButton.isHidden = true
            setLabels()
            label2.text = "- II"
            label2.font = UIFont.boldSystemFont(ofSize: 20.0)
            narrativeView.imageView.image = UIImage(named: "chapter1_02")
        case 5:
            narrativeView.backgroundColor = AppColor.lightBackground.value
            narrativeSlide.isHidden = true
            playButton.isHidden = true
            setLabels()
            label3.text = "- III"
            label3.font = UIFont.boldSystemFont(ofSize: 20.0)
            narrativeView.imageView.image = UIImage(named: "chapter1_03")
        case 7:
            narrativeView.backgroundColor = AppColor.lightBackground.value
            narrativeSlide.isHidden = true
            playButton.isHidden = true
            setLabels()
            label4.text = "- IV"
            label4.font = UIFont.boldSystemFont(ofSize: 20.0)
            narrativeView.imageView.image = UIImage(named: "chapter1_03")
        case 9:
            narrativeView.backgroundColor = AppColor.lightBackground.value
            narrativeSlide.isHidden = true
            playButton.isHidden = false
            setLabels()
            label5.text = "- V"
            label5.font = UIFont.boldSystemFont(ofSize: 20.0)
            narrativeView.imageView.image = UIImage(named: "chapter1_03")
        default:
            break
        }
        
    }
    
    func setLabels(){
        for elem in labels{
            elem.font = UIFont.systemFont(ofSize: 20.0)
            elem.text = "-"
        }
    }
    

}
