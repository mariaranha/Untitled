//
//  ChapterMenuViewController.swift
//  Untitled
//
//  Created by Julia Conti Mestre on 14/10/20.
//

import UIKit

class ChapterMenuViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var albumButton: UIButton!
    @IBOutlet weak var chapterView: ChapterView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var chapterNumCollection: UICollectionView!
    
    var numChapters: Int = 5
    var chapters: [ChapterView] = []
    let numCellPerPage: CGFloat = 5.0
    var pageIndex: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        chapterNumCollection.delegate = self
        
        //Set view
        self.view.backgroundColor = AppColor.lightBackground.value
        chapterView.backgroundColor = AppColor.lightBackground.value
        
        //Set button
        startButton.layer.borderWidth = 3.0
        startButton.layer.borderColor = AppColor.intermediateBorder.value.cgColor
        startButton.layer.backgroundColor = AppColor.lightBackground.value.cgColor
        startButton.setTitleColor(AppColor.intermediateLightText.value, for: .normal)
        startButton.setTitle("Entrar", for: .normal)
        
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
    
    func createChapters() -> [ChapterView] {
        
        for chapterNumber in 0..<numChapters {
            let chapter: ChapterView = Bundle.main.loadNibNamed("ChapterView", owner: self, options: nil)?.first as! ChapterView
            chapter.chapterTitle.textColor = AppColor.highlightText.value
            chapter.chapterSubtitle.textColor = AppColor.lightText.value
            chapter.photoDescription.textColor = AppColor.intermediateLightText.value
            chapter.photoDate.textColor = AppColor.darkText.value

            chapter.backgroundColor = AppColor.lightBackground.value
            chapter.chapterBackground.backgroundColor = AppColor.intermediateBackground.value
            chapter.photoFrame.backgroundColor = AppColor.lightBackground.value
            chapter.photoBackground.backgroundColor = AppColor.intermediateBackground.value
            chapter.photoBackground.image = UIImage(named: "chapterBackground_\(chapterNumber+1)")
            chapter.photoFront.image = UIImage(named: "chapterFront_\(chapterNumber+1)")

            chapter.photoFrame.rotate(angle: -2.0)

            
            switch chapterNumber {
            case 0:
                chapter.chapterTitle.text = "capítulo um"
                chapter.chapterSubtitle.text = "uma história de carnaval"
                chapter.photoDescription.text = "quando lutamos pelo carnaval"
                chapter.photoDate.text = "12 de fevereiro"
            case 1:
                chapter.chapterTitle.text = "capítulo dois"
                chapter.chapterSubtitle.text = "uma história de carnaval"
                chapter.photoDescription.text = "quando lutamos pelo carnaval"
                chapter.photoDate.text = "12 de fevereiro"
            case 2:
                chapter.chapterTitle.text = "capítulo três"
                chapter.chapterSubtitle.text = "uma história de carnaval"
                chapter.photoDescription.text = "quando lutamos pelo carnaval"
                chapter.photoDate.text = "12 de fevereiro"
            default:
                chapter.chapterTitle.text = "capítulo \(chapterNumber + 1)"
            }
            
            chapters.append(chapter)
        }
        
        return chapters
    }
    
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
            pageIndex = scrollPageIndex
            let indexPath = IndexPath(row: 0, section: 0)
            chapterNumCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } else if pageIndex != scrollPageIndex && scrollPageIndex > 0 {
            pageIndex = scrollPageIndex
            let indexPath = IndexPath(row: Int(pageIndex), section: 0)
            chapterNumCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}

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

    func getCellWidth() -> CGFloat {
        var cellWidth: CGFloat
        
        cellWidth = chapterView.frame.width / numCellPerPage
        
        return cellWidth
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
}

extension UIView {
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
    }
}
