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

    // MARK: Class Variables
    var numPages: Int = 0
    var chapter: Int = 0
    var narratives: [NarrativeView] = []
    var pageIndex: Int = 0
    
    var dismissFunc : (() -> Void)?
    var dismissNarrative : (() -> Void)?
    
    let language = UserDefaultsStruct.Language.preferLanguage
    
    //MARK: Init
    init?(chapterNumber: Int, coder: NSCoder) {
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
            numPages = 0
        }

        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: View Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        
        //Change number of pages here without init
        switch chapter {
        case 1:
            numPages = 6
        case 2:
            numPages = 6
        case 3:
            numPages = 6
        default:
            numPages = 0
        }
        
        //setup view
        let language = UserDefaultsStruct.Language.preferLanguage
        backgroundImage.image = UIImage(named: "narrative_background")
        narrativeSlide.text = "deslize para ler".localized(language)
        narrativeSlide.textColor = AppColor.lightText.value
        playButton.setImage(UIImage(named: "remember_button".localized(language)), for: .normal)
        playButton.isHidden = true
        
        view.layoutIfNeeded()
        view.layoutSubviews()
        
        //Setup pages
        narratives = createNarratives()
        setupScrollView(narratives: narratives)
    }
    
    //MARK: Narratives
    func createNarratives() -> [NarrativeView] {
        for narrativeNumber in 1...numPages {
            let narrative: NarrativeView = Bundle.main.loadNibNamed("NarrativeView", owner: self, options: nil)?.first as! NarrativeView
            
            narrative.imageView.image = UIImage(named: "chapter\(String(describing: chapter))_page\(narrativeNumber)".localized(language))
            
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
        setNumberLayout()
        
        if pageIndex == numPages - 1 {
            playButton.isHidden = false
            narrativeSlide.isHidden = true
        } else {
            playButton.isHidden = true
            narrativeSlide.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? GameViewController {
            vc.dismissNarrative = {
                self.dismiss(animated: false, completion: nil)
            }
            vc.restartNarrative = {
                self.performSegue(withIdentifier: "toBoardSegue", sender: self)
            }
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        let view = ExitView()
        view.tag = 100
        view.delegate = self
        view.alpha = 0.0
        self.view.addSubview(view)
        view.dismiss = {
            self.dismiss(animated: true, completion: nil)
            self.dismissNarrative?()
        }
        view.cancel = {
            UIView.animate(withDuration: 0.5, animations: {
                view.alpha = 0.0
            }) { (completion) in
                view.removeFromSuperview()
            }
        }
        UIView.animate(withDuration: 0.5, animations: {
            view.alpha = 1.0
        })
    }
    
}

// MARK: Number CollectionView
extension NarrativeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numPages
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pageCell", for: indexPath) as! NarrativePageCell
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = .clear
        cell.pageLabel.textColor = AppColor.intermediateDarkText.value
        cell.pageLabel.font = UIFont(name: "Alegreya Medium", size: 18.0)
        cell.pageLabel.text = "-"
        
        if indexPath.row == 0 {
            cell.pageLabel.font = UIFont(name: "Alegreya ExtraBold", size: 18.0)
            cell.pageLabel.text = "- I"
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellHeight: CGFloat = 40.0
        let collectionWidth = indexCollection.frame.width
        
        return CGSize(width: collectionWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let totalHeight = 40 * collectionView.numberOfItems(inSection: 0)

        let topInset = (collectionView.layer.frame.size.height - CGFloat(totalHeight)) / 2
        let bottomInset = topInset

        return UIEdgeInsets(top: topInset, left: 0, bottom: bottomInset, right: 0)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func setCellNumber(row: Int) -> String {
        var cellText: String
        
        switch row {
        case 0:
            cellText = "- I"
        case 1:
            cellText = "- II"
        case 2:
            cellText = "- III"
        case 3:
            cellText = "- IV"
        case 4:
            cellText = "- V"
        case 5:
            cellText = "- VI"
        case 6:
            cellText = "- VII"
        case 7:
            cellText = "- VIII"
        case 8:
            cellText = "- IX"
        case 9:
            cellText = "- X"
        case 10:
            cellText = "- XI"
        default:
            cellText = ""
        }
        
        return cellText
    }
    
    func setNumberLayout() {
        for row in 0..<numPages {
            let indexPath = IndexPath(row: row, section: 0)
            guard let cell = indexCollection.cellForItem(at: indexPath) as? NarrativePageCell else { return }
            if row == pageIndex {
                cell.pageLabel.font = UIFont(name: "Alegreya ExtraBold", size: 18.0)
                cell.pageLabel.text = setCellNumber(row: row)
            } else {
                cell.pageLabel.font = UIFont(name: "Alegreya Medium", size: 18.0)
                cell.pageLabel.text = "-"
            }
        }
    }
}
