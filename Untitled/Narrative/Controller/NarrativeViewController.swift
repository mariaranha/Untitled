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
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var narrativeSlide: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var indexCollection: UICollectionView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    var labels: [UILabel] = []

    // MARK: Class Variables
    var numPages: Int = 6
    var chapter: Int = 1
    var narratives: [NarrativeView] = []
    var pageIndex: Int = 0
    
    //MARK: Init
    init(chapterNumber: Int) {
        super.init(nibName: nil, bundle: nil)
        
        self.chapter = chapterNumber
        
        //Change number of pages here
        switch chapter {
        case 1:
            numPages = 6
        case 2:
            numPages = 6
        case 3:
            numPages = 6
        default:
            numPages = 6
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: View Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        
        //setup view
        backgroundImage.image = UIImage(named: "narrative_background")
        narrativeSlide.text = "deslize para ler"
        narrativeSlide.textColor = AppColor.lightText.value
        playButton.isHidden = true
        
        view.layoutIfNeeded()
        view.layoutSubviews()
        
        //Setup pages
        narratives = createNarratives()
        setupScrollView(narratives: narratives)
//        labels  = [label1, label2, label3, label4, label5, label6]
    }
    
    //MARK: Narratives
    func createNarratives() -> [NarrativeView] {
        for narrativeNumber in 1...numPages {
            let narrative: NarrativeView = Bundle.main.loadNibNamed("NarrativeView", owner: self, options: nil)?.first as! NarrativeView
            
            narrative.imageView.image = UIImage(named: "chapter\(String(describing: chapter))_page\(narrativeNumber)")
            
            narratives.append(narrative)
        }
        
        return narratives
    }
    
    // MARK: ScrollView
    func setupScrollView(narratives: [NarrativeView]) {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        scrollView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        scrollView.contentSize = CGSize(width: screenWidth,
                                        height: screenHeight * CGFloat(numPages))
        scrollView.isPagingEnabled = true
        
        let narrativeFrame = narrativeView.frame
        
        for i in 0 ..< narratives.count {
            narratives[i].frame = CGRect(x: narrativeFrame.origin.x,
                                         y: narrativeFrame.origin.y + screenHeight  * CGFloat(i),
                                         width: narrativeFrame.width,
                                         height: narrativeFrame.height)
            scrollView.addSubview(narratives[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPageIndex = floor(scrollView.contentOffset.y/scrollView.frame.height)
        
        pageIndex = Int(scrollPageIndex)
        
        if pageIndex == numPages - 1 {
            playButton.isHidden = false
            narrativeSlide.isHidden = true
        } else {
            playButton.isHidden = true
            narrativeSlide.isHidden = false
        }
    }
    
    
    
    
    
    
    
    
    

    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let currentPage = Int((scrollView.contentOffset.y)/(scrollView.frame.size.height))
//        setLabels()
//        playButton.isHidden = true
//        narrativeSlide.isHidden = false
//        switch currentPage {
//        case 0:
////            playButton.isHidden = true
////            narrativeSlide.isHidden = false
//            label1.text = "- I"
//            label1.font = UIFont.boldSystemFont(ofSize: 20.0)
//            narrativeView.imageView.image = UIImage(named: "chapter1_page1")
//        case 1:
////            narrativeSlide.isHidden = true
////            playButton.isHidden = true
//            label2.text = "- II"
//            label2.font = UIFont.boldSystemFont(ofSize: 20.0)
//            narrativeView.imageView.image = UIImage(named: "chapter1_page2")
//        case 2:
////            narrativeSlide.isHidden = true
////            playButton.isHidden = true
//            label3.text = "- III"
//            label3.font = UIFont.boldSystemFont(ofSize: 20.0)
//            narrativeView.imageView.image = UIImage(named: "chapter1_page3")
//        case 3:
////            narrativeSlide.isHidden = true
////            playButton.isHidden = true
//            label4.text = "- IV"
//            label4.font = UIFont.boldSystemFont(ofSize: 20.0)
//            narrativeView.imageView.image = UIImage(named: "chapter1_page4")
//        case 4:
////            narrativeSlide.isHidden = true
////            playButton.isHidden = false
//            label5.text = "- V"
//            label5.font = UIFont.boldSystemFont(ofSize: 20.0)
//            narrativeView.imageView.image = UIImage(named: "chapter1_page5")
//        case 5:
//            narrativeSlide.isHidden = true
////            playButton.isHidden = false
//            label6.text = "- VI"
//            label6.font = UIFont.boldSystemFont(ofSize: 20.0)
//            narrativeView.imageView.image = UIImage(named: "chapter1_page6")
//            playButton.isHidden = false
//        default:
//            break
//        }
//
//    }
    
    func setLabels(){
        for elem in labels{
            elem.font = UIFont.systemFont(ofSize: 20.0)
            elem.text = "-"
        }
    }
    

}
