//
//  OpenAlbumViewController.swift
//  Untitled
//
//  Created by Julia Conti Mestre on 23/10/20.
//

import UIKit

protocol PhotoDetail: NSObjectProtocol {
    func showPhotoDetail(photoPosition: Int)
}

class OpenAlbumViewController: UIViewController, PhotoDetail {
    @IBOutlet weak var albumPage: OpenAlbumView!
    @IBOutlet weak var initialStoryButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var pageStack: UIStackView!
    @IBOutlet weak var previousPageButton: UIButton!
    @IBOutlet weak var nextPageButton: UIButton!
    @IBOutlet weak var closeAlbumButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var leadingPageConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingPageConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var photoDetailBackground: UIView!
    @IBOutlet weak var photoDetail: UIImageView!
    
    enum AlbumPageType {
        case left
        case right
    }
    
    var currentPage: Int = 1
    var totalPages: Int = 5
    var pageType: AlbumPageType = .left
    var photoTapped: Int = 0
    
    var unlockedRewards: [Int] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        getUnlockedRewards()

        view.backgroundColor = AppColor.lightBackground.value
        albumPage.photoDetailDelegate = self
        
        view.setNeedsLayout()
        
        //Set first view
        photoDetailBackground.isHidden = true
        
        //Set Pages
        setPageButtons()
        setPageConstraints()
        setPageLayout()
    }
    
    func getUnlockedRewards() {
        //Unlocked Rewards - User Defaults
        UserDefaultsStruct.Rewards.getRewards()
        let rewards = UserDefaultsStruct.rewards
        
        var index: Int = 0
        for reward in rewards {
            index += 1
            if reward.value == true {
                unlockedRewards.append(index)
            }
        }
        
        print(unlockedRewards)
    }
    
    func setPageConstraints() {
        
        leadingPageConstraint.constant = 0
        trailingPageConstraint.constant = 0
        
        if currentPage % 2 == 0 {
            pageType = .right
            trailingButtonConstraint.priority = UILayoutPriority(1000)
            leadingButtonConstraint.priority = UILayoutPriority(750.0)
            trailingButtonConstraint.constant = 16

        } else {
            pageType = .left
            leadingButtonConstraint.priority = UILayoutPriority(1000)
            trailingButtonConstraint.priority = UILayoutPriority(750.0)
            leadingButtonConstraint.constant = 16
        }
        
    }
    
    func disablePreviousButton() {
        previousPageButton.setImage(UIImage(named: "backArrowDisabled"), for: .normal)
        previousPageButton.isUserInteractionEnabled = false
        
        nextPageButton.setImage(UIImage(named: "nextArrow"), for: .normal)
        nextPageButton.isUserInteractionEnabled = true
    }
    
    func disableNextButton() {
        previousPageButton.setImage(UIImage(named: "backArrow"), for: .normal)
        previousPageButton.isUserInteractionEnabled = true
        
        nextPageButton.setImage(UIImage(named: "nextArrowDisabled"), for: .normal)
        nextPageButton.isUserInteractionEnabled = false
    }
    
    func enableButtons() {
        previousPageButton.setImage(UIImage(named: "backArrow"), for: .normal)
        nextPageButton.setImage(UIImage(named: "nextArrow"), for: .normal)
        
        previousPageButton.isUserInteractionEnabled = true
        nextPageButton.isUserInteractionEnabled = true
    }
    
    func setPageButtons() {
        if photoDetailBackground.isHidden {
            if currentPage == 1 {
                disablePreviousButton()
            } else if currentPage == totalPages {
                disableNextButton()
            } else {
                enableButtons()
            }
        } else {
            if photoTapped == 1 {
                disablePreviousButton()
            } else if photoTapped == totalPages * 2 {
                disableNextButton()
            } else {
                enableButtons()
            }
        }
    }
    
    func setPageLayout() {
        switch pageType {
        case .left:
            albumPage.albumPage.image = UIImage(named: "leftOpenPage")
            
            albumPage.topPhotoWidth.constant = 174
            albumPage.topPhotoLeadingConstraint.constant = 15
            albumPage.topPhotoTrailingConstraint.constant = 185
            albumPage.topPhotoTopConstraint.constant = 50
            
            albumPage.bottomPhotoWidth.constant = 179
            albumPage.bottomPhotoLeadingConstraint.constant = 195
            albumPage.bottomPhotoTrailingConstraint.constant = 0
            albumPage.bottomPhotoBottomConstraint.constant = 80
            
            backgroundImage.image = UIImage(named: "rewards_background")
        case .right:
            albumPage.albumPage.image = UIImage(named: "rightOpenPage")
            
            albumPage.topPhotoWidth.constant = 174
            albumPage.topPhotoLeadingConstraint.constant = 185
            albumPage.topPhotoTrailingConstraint.constant = 15
            albumPage.topPhotoTopConstraint.constant = 50
            
            albumPage.bottomPhotoWidth.constant = 179
            albumPage.bottomPhotoLeadingConstraint.constant = 0
            albumPage.bottomPhotoTrailingConstraint.constant = 195
            albumPage.bottomPhotoBottomConstraint.constant = 80
            
            backgroundImage.image = UIImage(named: "rewards_background_2")
        }
        
        var topPagePhoto: Int
        var bottomPagePhoto: Int
        
        topPagePhoto = currentPage * 2 - 1
        bottomPagePhoto = currentPage * 2
        
        if unlockedRewards.contains(topPagePhoto) {
            albumPage.topPhotoButton.setImage(UIImage(named: "unlockedPhoto_0\(topPagePhoto)"), for: .normal)
        } else {
            if pageType == .left{
                albumPage.topPhotoButton.setImage(UIImage(named: "emptyReward1"), for: .normal)
            }else{
                albumPage.topPhotoButton.setImage(UIImage(named: "emptyReward3"), for: .normal)
            
            }
        }
        
        if unlockedRewards.contains(bottomPagePhoto) {
            albumPage.bottomPhotoButton.setImage(UIImage(named: "unlockedPhoto_0\(bottomPagePhoto)"), for: .normal)
        } else {
            if pageType == .left{
                albumPage.bottomPhotoButton.setImage(UIImage(named: "emptyReward2"), for: .normal)
            } else {
                albumPage.bottomPhotoButton.setImage(UIImage(named: "emptyReward4"), for: .normal)
            }
        }
        
    }
    
    func setPhotoDetailLayout() {
        if unlockedRewards.contains(photoTapped) {
            photoDetail.image = UIImage(named: "unlockedDetail_0\(photoTapped)")
        } else {
            photoDetail.image = UIImage(named: "lockedDetail")
        }
    }
    
    func showPhotoDetail(photoPosition: Int) {
        var topPagePhoto: Int
        var bottomPagePhoto: Int
        
        topPagePhoto = currentPage * 2 - 1
        bottomPagePhoto = currentPage * 2
        
        if photoPosition == 0 {
            photoTapped = topPagePhoto
        } else {
            photoTapped = bottomPagePhoto
        }
        
        photoDetailBackground.isHidden = false
        setPhotoDetailLayout()
    }
    
    func nextPage() {
        currentPage += 1
        setPageButtons()
        setPageConstraints()
        setPageLayout()
    }
    
    func previousPage() {
        currentPage -= 1
        setPageButtons()
        setPageConstraints()
        setPageLayout()
    }
    
    func nextPhoto() {
        photoTapped += 1
        setPageButtons()
        setPhotoDetailLayout()
    }
    
    func previousPhoto() {
        photoTapped -= 1
        setPageButtons()
        setPhotoDetailLayout()
    }
    
    @IBAction func nextPageOrPhoto(_ sender: UIButton) {
        if photoDetailBackground.isHidden {
            nextPage()
        } else {
            nextPhoto()
        }
    }
    
    @IBAction func previousPageOrPhoto(_ sender: UIButton) {
        if photoDetailBackground.isHidden {
            previousPage()
        } else {
            previousPhoto()
        }
    }
    
    @IBAction func closeAlbumOrPhoto(_ sender: Any) {
        if photoDetailBackground.isHidden {
            setPageButtons()
            self.performSegue(withIdentifier: "backToCloseAlbum", sender: self)
        } else {
            photoDetailBackground.isHidden = true
            setPageButtons()
        }
    }
    
}
