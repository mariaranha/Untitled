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
    
    // MARK: View Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        //setup view
        self.backgroundView.backgroundColor = AppColor.lightBackground.value
        
        //Setup pages
        setupPageScrollView()
        labels  = [label1, label2, label3, label4, label5]
    }
    
    // MARK: ScrollView
    func setupPageScrollView(){
        let contentWidth = backgroundView.bounds.width
        let contentHeight = backgroundView.bounds.height * CGFloat(numPages)
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int((scrollView.contentOffset.y)/(scrollView.frame.size.height))
        
        switch currentPage {
        case 0:
            narrativeView.backgroundColor = AppColor.lightBackground.value
            playButton.isHidden = true
            narrativeSlide.isHidden = false
            setLabels()
            label1.text = "- I"
            label1.font = UIFont.boldSystemFont(ofSize: 20.0)
            narrativeView.imageView.image = UIImage(named: "chapter1_01")
        case 1:
            narrativeView.backgroundColor = AppColor.lightBackground.value
            narrativeSlide.isHidden = true
            playButton.isHidden = true
            setLabels()
            label2.text = "- II"
            label2.font = UIFont.boldSystemFont(ofSize: 20.0)
            narrativeView.imageView.image = UIImage(named: "chapter1_02")
        case 2:
            narrativeView.backgroundColor = AppColor.lightBackground.value
            narrativeSlide.isHidden = true
            playButton.isHidden = true
            setLabels()
            label3.text = "- III"
            label3.font = UIFont.boldSystemFont(ofSize: 20.0)
            narrativeView.imageView.image = UIImage(named: "chapter1_03")
        case 3:
            narrativeView.backgroundColor = AppColor.lightBackground.value
            narrativeSlide.isHidden = true
            playButton.isHidden = true
            setLabels()
            label4.text = "- IV"
            label4.font = UIFont.boldSystemFont(ofSize: 20.0)
            narrativeView.imageView.image = UIImage(named: "chapter1_03")
        case 4:
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
