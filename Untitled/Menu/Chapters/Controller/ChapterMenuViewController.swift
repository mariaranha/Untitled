//
//  ChapterMenuViewController.swift
//  Untitled
//
//  Created by Julia Conti Mestre on 14/10/20.
//

import UIKit

class ChapterMenuViewController: UIViewController, UIScrollViewDelegate {
    // MARK: IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var albumButton: UIButton!
    @IBOutlet weak var chapterView: ChapterView!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var chapterNumCollection: UICollectionView!
    @IBOutlet weak var enterButtonLine: UIImageView!
    
    // MARK: Class Variables
    var numChapters: Int = 5
    var chapters: [ChapterView] = []
    let numCellPerPage: CGFloat = 5.0
    var pageIndex: Int = 0
    var userLevel: Int = 0
    
    let language = UserDefaultsStruct.Language.preferLanguage
    
    // MARK: View Cicle
    override func viewDidLoad() {
        super.viewDidLoad()

        userLevel = UserDefaultsStruct.UserLevel.level
        
        scrollView.delegate = self
        chapterNumCollection.delegate = self
        
        //Set view
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "chapters_background1")!)
        enterButton.setImage(UIImage(named: "enter_button".localized(language)), for: .normal)
        enterButtonLine.backgroundColor = AppColor.intermediateBorder.value
        
        //Set Chapters
        view.layoutIfNeeded()
        chapters = createChapters()
        setupChapterScrollView(chapters: chapters)
        
        //Set chapter number cell
        let cellWidth = getCellWidth()
        let layout = chapterNumCollection.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionInset = .init(top: 0,
                                     left: cellWidth * 2,
                                     bottom: 0,
                                     right: 0)

    
    }
    
    @IBAction func backToChaptersMenu(_ sender: UIStoryboardSegue) {
    }
    
    @IBAction func startPressed(_ sender: Any) {
//        let viewController = UIStoryboard(name: "Narrative", bundle: nil).instantiateViewController(identifier: "chapterNarrative", creator: { coder in
//            NarrativeViewController(chapterNumber: self.pageIndex + 1, coder: coder)
//            })
//        viewController.modalTransitionStyle = .crossDissolve
//        viewController.modalPresentationStyle = .fullScreen
//
//        present(viewController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chapterNarrative" {
            let viewController = segue.destination as! NarrativeViewController
            viewController.chapter = self.pageIndex + 1
        }
    }
    
    // MARK: Chapters
    func createChapters() -> [ChapterView] {
        
        for chapterNumber in 1...numChapters {
            let chapter: ChapterView = Bundle.main.loadNibNamed("ChapterView", owner: self, options: nil)?.first as! ChapterView
            
            if chapterNumber > userLevel {
                setLockedChapters(chapter)
            } else {
                setUnlockedChapters(chapter, chapterNumber)
            }

            setChaptersLabels(chapterNumber, chapter)
            
            chapters.append(chapter)
        }

        return chapters
    }
    
    fileprivate func setLockedChapters(_ chapter: ChapterView) {
        chapter.chapterTitle.textColor = .black
        chapter.chapterSubtitle.textColor = .clear
        chapter.chapterBackground.image = UIImage(named: "blocked_background")
        
        chapter.chapterBackground.backgroundColor = .lightGray
    }
    
    fileprivate func setUnlockedChapters(_ chapter: ChapterView, _ chapterNumber: Int) {
        chapter.chapterTitle.textColor = AppColor.highlightText.value
        chapter.chapterSubtitle.textColor = AppColor.lightText.value
        chapter.chapterBackground.image = UIImage(named: "chapter\(chapterNumber)_background")
    }
    
    fileprivate func setChaptersLabels(_ chapterNumber: Int, _ chapter: ChapterView) {
        
        switch chapterNumber {
        case 1:
            chapter.chapterTitle.text = "capítulo um".localized(language)
            chapter.chapterSubtitle.text = "uma história de carnaval".localized(language)
        case 2:
            chapter.chapterTitle.text = "capítulo dois".localized(language)
            chapter.chapterSubtitle.text = "o bloco em movimento".localized(language)
        case 3:
            chapter.chapterTitle.text = "capítulo três".localized(language)
            chapter.chapterSubtitle.text = "capítulo três subtitulo".localized(language)
        case 4:
            chapter.chapterTitle.text = "capítulo quatro".localized(language)
            chapter.chapterSubtitle.text = "capítulo quatro subtitulo".localized(language)
        case 5:
            chapter.chapterTitle.text = "capítulo cinco".localized(language)
            chapter.chapterSubtitle.text = "capítulo cinco subtitulo".localized(language)
        default:
            chapter.chapterTitle.text = "capítulo \(chapterNumber)"
        }
    }
    
    // MARK: ScrollView
    func setupChapterScrollView(chapters: [ChapterView]) {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        scrollView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        scrollView.contentSize = CGSize(width: screenWidth * CGFloat(numChapters), height: screenHeight)
        scrollView.isPagingEnabled = true
        
        view.layoutSubviews()
        for i in 0 ..< chapters.count {
            chapters[i].frame = CGRect(x: chapterView.frame.width * CGFloat(i),
                                       y: chapterView.frame.minY,
                                       width: chapterView.frame.width,
                                       height: chapterView.frame.height)
            scrollView.addSubview(chapters[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPageIndex = floor(scrollView.contentOffset.x/view.frame.width)
        let direction = scrollView.panGestureRecognizer.translation(in: scrollView.superview).x
        
        // Scroll chapter number
        if scrollPageIndex == 0 && pageIndex == 1 && direction > 0 {
            pageIndex = Int(scrollPageIndex)
            let indexPath = IndexPath(row: 0, section: 0)
            chapterNumCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            setNumberColor()
        } else if pageIndex != Int(scrollPageIndex) && scrollPageIndex > 0 {
            pageIndex = Int(scrollPageIndex)
            let indexPath = IndexPath(row: Int(pageIndex), section: 0)
            chapterNumCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            setNumberColor()
        }
        
        //Start button for unlocked levels
        if pageIndex + 1 > userLevel {
            enterButton.isHidden = true
            enterButtonLine.backgroundColor = AppColor.darkBorder.value
        } else {
            enterButton.isHidden = false
            enterButtonLine.backgroundColor = AppColor.intermediateBorder.value
        }
    }
    
}

// MARK: Number CollectionView
extension ChapterMenuViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numChapters + 2
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "numCell", for: indexPath) as! ChapterNumCell
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = .clear
        cell.number.textColor = AppColor.intermediateDarkText.value
        
        if indexPath.row == 0 {
            cell.number.textColor = AppColor.intermediateLightText.value
        }
        
        if indexPath.row < 9 {
            cell.number.text = "0\(indexPath.row + 1)"
        } else {
            cell.number.text = "\(indexPath.row + 1)"
        }
        
        if indexPath.row > numChapters - 1 {
            cell.number.text = ""
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = getCellWidth()
        let collectionHeight = chapterNumCollection.frame.height
        
        return CGSize(width: cellWidth, height: collectionHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func getCellWidth() -> CGFloat {
        var cellWidth: CGFloat
        
        cellWidth = chapterView.frame.width / numCellPerPage
        
        return cellWidth
    }
    
    func setNumberColor() {
        for row in 0..<userLevel {
            let indexPath = IndexPath(row: row, section: 0)
            guard let cell = chapterNumCollection.cellForItem(at: indexPath) as? ChapterNumCell else { return }
            if row == pageIndex {
                cell.number.textColor = AppColor.intermediateLightText.value
            } else {
                cell.number.textColor = AppColor.intermediateDarkText.value
            }
        }
    }
}

// MARK: Rotate
extension UIView {
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
    }
}
