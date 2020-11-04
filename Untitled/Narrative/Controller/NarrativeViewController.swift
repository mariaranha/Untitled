//
//  NarrativeViewController.swift
//  Untitled
//
//  Created by Marina Miranda Aranha on 17/10/20.
//

import UIKit

class NarrativeViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: IBOutlets
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var narrativeView: NarrativeView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var narrativeSlide: UILabel!
    @IBOutlet weak var indexPageStackView: UIStackView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    var labels: [UILabel] = []
    
    // MARK: Class Variables
    var numPages: Int = 6
    
    // MARK: View Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        //setup view
        backgroundView.backgroundColor = UIColor(patternImage: UIImage(named: "narrative_background")!)
        
        //Setup pages
        setupPageScrollView()
        labels  = [label1, label2, label3, label4, label5, label6]
    }
    
    // MARK: ScrollView
    func setupPageScrollView(){
        let contentWidth = backgroundView.bounds.width
        let contentHeight = backgroundView.bounds.height * CGFloat(numPages)
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int((scrollView.contentOffset.y)/(scrollView.frame.size.height))
        setLabels()
        playButton.isHidden = true
        narrativeSlide.isHidden = false
        switch currentPage {
        case 0:
//            playButton.isHidden = true
//            narrativeSlide.isHidden = false
            label1.text = "- I"
            label1.font = UIFont.boldSystemFont(ofSize: 20.0)
            narrativeView.imageView.image = UIImage(named: "chapter1_page1")
        case 1:
//            narrativeSlide.isHidden = true
//            playButton.isHidden = true
            label2.text = "- II"
            label2.font = UIFont.boldSystemFont(ofSize: 20.0)
            narrativeView.imageView.image = UIImage(named: "chapter1_page2")
        case 2:
//            narrativeSlide.isHidden = true
//            playButton.isHidden = true
            label3.text = "- III"
            label3.font = UIFont.boldSystemFont(ofSize: 20.0)
            narrativeView.imageView.image = UIImage(named: "chapter1_page3")
        case 3:
//            narrativeSlide.isHidden = true
//            playButton.isHidden = true
            label4.text = "- IV"
            label4.font = UIFont.boldSystemFont(ofSize: 20.0)
            narrativeView.imageView.image = UIImage(named: "chapter1_page4")
        case 4:
//            narrativeSlide.isHidden = true
//            playButton.isHidden = false
            label5.text = "- V"
            label5.font = UIFont.boldSystemFont(ofSize: 20.0)
            narrativeView.imageView.image = UIImage(named: "chapter1_page5")
        case 5:
            narrativeSlide.isHidden = true
//            playButton.isHidden = false
            label6.text = "- VI"
            label6.font = UIFont.boldSystemFont(ofSize: 20.0)
            narrativeView.imageView.image = UIImage(named: "chapter1_page6")
            playButton.isHidden = false
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
