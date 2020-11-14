//
//  TutorialViewController.swift
//  Untitled
//
//  Created by Julia Conti Mestre on 13/11/20.
//

import UIKit

//  MARK: TUTORIAL GENERIC FUNCS
extension GameViewController {
    
    func setUpTutorial() {
        cardBoard.isUserInteractionEnabled = false
        
        //Set up image
        let screenFrame = view.bounds
        let imageWidth = screenFrame.width - 64
        tutorialImageView.frame = CGRect(x: 32, y: 0, width: imageWidth, height: screenFrame.height)
        tutorialImageView.contentMode = .scaleAspectFit
        
        //Set up label
        continueTutorialLabel.text = "clique para continuar".localized(language)
        continueTutorialLabel.font = UIFont(name: "Lalezar", size: 20)
        continueTutorialLabel.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        continueTutorialLabel.shadowOffset = CGSize(width: 1, height: 1)
        continueTutorialLabel.textColor = AppColor.lightText.value
        continueTutorialLabel.frame.size = CGSize(width: view.frame.width, height: 30.0)
        continueTutorialLabel.textAlignment = .center
        continueTutorialLabel.translatesAutoresizingMaskIntoConstraints = true
        continueTutorialLabel.center = CGPoint(x: view.bounds.midX, y: view.frame.height - 32)
        continueTutorialLabel.autoresizingMask = [UIView.AutoresizingMask.flexibleLeftMargin, UIView.AutoresizingMask.flexibleRightMargin, UIView.AutoresizingMask.flexibleTopMargin, UIView.AutoresizingMask.flexibleBottomMargin]
        
        //Set Tap
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(GameViewController.tap(sender:)))
        tapView.addGestureRecognizer(tap)
        
        //Add subviews
        view.addSubview(tutorialPage)
        view.addSubview(tutorialImageView)
        view.addSubview(continueTutorialLabel)
        view.addSubview(tapView)
        view.bringSubviewToFront(tapView)
        
        switch currentLevel {
        case 1:
            lifePage()
        case 2:
            conservativePage()
        case 3:
            costumePage()
        default:
            break
        }
    }
    
    func endTutorial() {
        cardBoard.isUserInteractionEnabled = true
        
        tutorialImageView.removeFromSuperview()
        tutorialPage.removeFromSuperview()
        continueTutorialLabel.removeFromSuperview()
        tapView.removeFromSuperview()
    }
    
    //MARK: TUTORIAL CHAPTER 1
    func lifePage() {
        tutorialImageView.image = UIImage(named: "tutorial_life".localized(language))
        
        view.bringSubviewToFront(tutorialPage)
        
        view.bringSubviewToFront(lifePhoto)
        view.bringSubviewToFront(currentLifeLabel)
        view.bringSubviewToFront(totalLifeLabel)
        
        view.bringSubviewToFront(tutorialImageView)
        view.bringSubviewToFront(continueTutorialLabel)
        view.bringSubviewToFront(tapView)
    }
    
    func lifeCardsPage() {
        tutorialImageView.image = UIImage(named: "tutorial_life_cards".localized(language))
        
        view.bringSubviewToFront(tutorialPage)
        view.bringSubviewToFront(tutorialImageView)
        view.bringSubviewToFront(continueTutorialLabel)
        view.bringSubviewToFront(tapView)
    }
    
    func memoriesPage() {
        tutorialImageView.image = UIImage(named: "tutorial_memories".localized(language))
        
        view.bringSubviewToFront(tutorialPage)
        
        view.bringSubviewToFront(progressBackground)
        view.bringSubviewToFront(photoReward)
        view.bringSubviewToFront(firstReward)
        view.bringSubviewToFront(secondReward)
        
        view.bringSubviewToFront(tutorialImageView)
        view.bringSubviewToFront(continueTutorialLabel)
        view.bringSubviewToFront(tapView)
    }
    
    func memoriesCardsPage() {
        tutorialImageView.image = UIImage(named: "tutorial_memories_cards".localized(language))
        
        view.bringSubviewToFront(tutorialPage)
        
        view.bringSubviewToFront(tutorialImageView)
        view.bringSubviewToFront(continueTutorialLabel)
        view.bringSubviewToFront(tapView)
    }
    
    func energyPage() {
        tutorialImageView.image = UIImage(named: "tutorial_energy".localized(language))
        
        view.bringSubviewToFront(tutorialPage)
        
        view.bringSubviewToFront(energy)
        view.bringSubviewToFront(energyStack)
        view.bringSubviewToFront(cityPhoto)
        
        view.bringSubviewToFront(tutorialImageView)
        view.bringSubviewToFront(continueTutorialLabel)
        view.bringSubviewToFront(tapView)
    }
    
    func energyCardsPage() {
        tutorialImageView.image = UIImage(named: "tutorial_energy_cards".localized(language))
        
        view.bringSubviewToFront(tutorialPage)
        
        view.bringSubviewToFront(tutorialImageView)
        view.bringSubviewToFront(continueTutorialLabel)
        view.bringSubviewToFront(tapView)
    }
    
    func leaveBoardPage() {
        albumView.frame = CGRect(origin: CGPoint(x: 0, y: 0),
                                 size: CGSize(width: view.frame.width, height: view.frame.height))
        albumView.image = UIImage(named: "board_album_highlighted")
        albumView.contentMode = .scaleAspectFill
        
        tutorialImageView.image = UIImage(named: "tutorial_leaveBoard".localized(language))
        
        view.addSubview(albumView)
        
        view.bringSubviewToFront(tutorialPage)
        
        view.bringSubviewToFront(albumView)
        view.bringSubviewToFront(tutorialImageView)
        view.bringSubviewToFront(continueTutorialLabel)
        view.bringSubviewToFront(tapView)
    }
    
    func endLeaveBoardPage() {
        albumView.removeFromSuperview()
    }
    
    
    //MARK: TUTORIAL CHAPTER 2
    func conservativePage() {
        tutorialImageView.image = UIImage(named: "tutorial_conservative".localized(language))
        
        view.bringSubviewToFront(tutorialPage)
        
        view.bringSubviewToFront(tutorialImageView)
        view.bringSubviewToFront(continueTutorialLabel)
        view.bringSubviewToFront(tapView)
    }
    
    //MARK: TUTORIAL CHAPTER 3
    func costumePage() {
        tutorialImageView.image = UIImage(named: "tutorial_costume".localized(language))
        
        view.bringSubviewToFront(tutorialPage)
        
        view.bringSubviewToFront(tutorialImageView)
        view.bringSubviewToFront(continueTutorialLabel)
        view.bringSubviewToFront(tapView)
    }
    
    //MARK: TAP HANDLER
    @objc func tap(sender: UIGestureRecognizer) {
        switch currentLevel {
        case 1:
            handleTapChapter1()
        case 2:
            endTutorial()
        case 3:
            endTutorial()
        default:
            break
        }
    }
    
    func handleTapChapter1() {
        switch currentTutorialPage {
        case 1:
            lifeCardsPage()
        case 2:
            memoriesPage()
        case 3:
            memoriesCardsPage()
        case 4:
            energyPage()
        case 5:
            energyCardsPage()
        case 6:
            leaveBoardPage()
        case 7:
            endLeaveBoardPage()
            endTutorial()
        default:
            break
        }
        
        currentTutorialPage += 1
    }
}
