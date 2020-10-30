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
    
    @IBOutlet weak var leadingPageConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingPageConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var photoDetailBackground: UIView!
    @IBOutlet weak var photoDetailDescription: UIImageView!
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
        
        //Set Close Album button
        closeAlbumButton.layer.borderColor = AppColor.intermediateBorder.value.cgColor
        closeAlbumButton.layer.borderWidth = 3.0
        closeAlbumButton.backgroundColor = AppColor.lightBackground.value
        
        //Set Back button
        backButton.setTitle("Voltar", for: .normal)
        
        //Set Pages button
        previousPageButton.layer.borderColor = AppColor.intermediateBorder.value.cgColor
        previousPageButton.layer.borderWidth = 3.0
        previousPageButton.backgroundColor = AppColor.lightBackground.value
        nextPageButton.layer.borderColor = AppColor.intermediateBorder.value.cgColor
        nextPageButton.layer.borderWidth = 3.0
        nextPageButton.backgroundColor = AppColor.lightBackground.value
        
        //Set angles
        albumPage.topPhoto.rotate(angle: -1.0)
        albumPage.topDescription.rotate(angle: -1.0)
        albumPage.bottomPhoto.rotate(angle: 1.0)
        albumPage.bottomDescription.rotate(angle: 1.0)
        
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
    }
    
    func setPageConstraints() {
        if currentPage % 2 == 0 {
            leadingPageConstraint.constant = 0
            trailingPageConstraint.constant = 32
            pageType = .right
        } else {
            leadingPageConstraint.constant = 32
            trailingPageConstraint.constant = 0
            pageType = .left
        }
    }
    
    func setPageButtons() {
        if photoDetailBackground.isHidden {
            if currentPage == 1 {
                previousPageButton.isHidden = true
            } else if currentPage == totalPages {
                nextPageButton.isHidden = true
            } else {
                previousPageButton.isHidden = false
                nextPageButton.isHidden = false
            }
        } else {
            if photoTapped == 1 {
                previousPageButton.isHidden = true
            } else if photoTapped == totalPages * 2 {
                nextPageButton.isHidden = true
            } else {
                previousPageButton.isHidden = false
                nextPageButton.isHidden = false
            }
        }
        
    }
    
    func setPageLayout() {
        albumPage.contentView.backgroundColor = AppColor.lightBackground.value
        
        switch pageType {
        case .left:
            albumPage.albumPage.image = UIImage(named: "leftOpenPage")
            albumPage.leadingPhotoConstraint.constant = 76
            albumPage.trailingPhotoConstraint.constant = 42
        case .right:
            albumPage.albumPage.image = UIImage(named: "rightOpenPage")
            albumPage.leadingPhotoConstraint.constant = 42
            albumPage.trailingPhotoConstraint.constant = 76
        }
        
        var topPagePhoto: Int
        var bottomPagePhoto: Int
        
        topPagePhoto = currentPage * 2 - 1
        bottomPagePhoto = currentPage * 2
        
        if unlockedRewards.contains(topPagePhoto) {
            albumPage.topPhoto.image = UIImage(named: "unlockedPhoto_0\(topPagePhoto)")
            albumPage.topDescription.image = UIImage(named: "unlockedLabel_0\(topPagePhoto)")
        } else {
            albumPage.topPhoto.image = UIImage(named: "lockedPhoto")
            albumPage.topDescription.image = UIImage(named: "lockedLabel")
        }
        
        if unlockedRewards.contains(bottomPagePhoto) {
            albumPage.bottomPhoto.image = UIImage(named: "unlockedPhoto_0\(bottomPagePhoto)")
            albumPage.bottomDescription.image = UIImage(named: "unlockedLabel_0\(bottomPagePhoto)")
        } else {
            albumPage.bottomPhoto.image = UIImage(named: "lockedPhoto")
            albumPage.bottomDescription.image = UIImage(named: "lockedLabel")
        }
        
    }
    
    func setPhotoDetailLayout() {
        if unlockedRewards.contains(photoTapped) {
            photoDetail.image = UIImage(named: "unlockedPhoto_0\(photoTapped)")
            photoDetailDescription.image = UIImage(named: "unlockedLabel_0\(photoTapped)")
        } else {
            photoDetail.image = UIImage(named: "lockedPhoto")
            photoDetailDescription.image = UIImage(named: "lockedLabel")
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
            self.performSegue(withIdentifier: "backToCloseAlbum", sender: self)
            setPageButtons()
        } else {
            photoDetailBackground.isHidden = true
            setPageButtons()
        }
    }
    
}
