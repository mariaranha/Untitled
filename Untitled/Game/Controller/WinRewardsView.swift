//
//  WinRewardsView.swift
//  Untitled
//
//  Created by Gabriel Ferreira on 11/11/20.
//

import Foundation
import UIKit

class WinRewardsView: UIView {
    public var delegate: UIViewController? {
        didSet {
            self.setConstraints()
        }
    }
    public var continueFunc : (() -> Void)?
    
    private var backView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .black
        view.alpha = 0.8
        
        return view
    }()
    public var continueButton: UIButton = {
        let btn = UIButton()
        let language = UserDefaultsStruct.Language.preferLanguage
        let img = UIImage(named: "continue_button".localized(language))
        
        btn.setImage(img, for: .normal)
        
        return btn
    }()
    public var memoriesImage: UIImageView = {
        let img = UIImageView()
        let language = UserDefaultsStruct.Language.preferLanguage
        img.image = UIImage(named: "memories_rewards".localized(language))
                
        return img
    }()
    public var rewardsImages: [UIImage?] = [UIImage(named: "board_collected_reward_1_1.png")]
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = .clear
        
        self.continueButton.addTarget(self, action: #selector(continueAction), for: .touchUpInside)
    }
    
    @objc func continueAction() {
        self.continueFunc?()
    }
    
    func setConstraints() {
        var images: [UIImageView] = []
        for img in self.rewardsImages {
            images.append(UIImageView(image: img))
        }
        
        let stackH = UIStackView(arrangedSubviews: images)
        let stackV = UIStackView(arrangedSubviews: [self.memoriesImage, self.continueButton])
        stackH.axis = .horizontal
        stackV.axis = .vertical
        stackV.alignment = .center
        stackV.spacing = 16
        
        self.memoriesImage.addSubview(stackH)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backView.translatesAutoresizingMaskIntoConstraints = false
        stackH.translatesAutoresizingMaskIntoConstraints = false
        stackV.translatesAutoresizingMaskIntoConstraints = false
        self.delegate?.view.addSubview(self)
        
        self.addSubview(self.backView)
        self.addSubview(stackV)
        
        let exitTop = self.topAnchor.constraint(equalTo: self.delegate!.view.topAnchor)
        let exitBottom = self.bottomAnchor.constraint(equalTo: self.delegate!.view.bottomAnchor)
        let exitLeading = self.leadingAnchor.constraint(equalTo: self.delegate!.view.leadingAnchor)
        let exitTrailing = self.trailingAnchor.constraint(equalTo: self.delegate!.view.trailingAnchor)
        let backTop = self.backView.topAnchor.constraint(equalTo: self.topAnchor)
        let backBottom = self.backView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        let backLeading = self.backView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let backTrailing = self.backView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        let stackVCenterX = stackV.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let stackVCenterY = stackV.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let stackHCenterX = stackH.centerXAnchor.constraint(equalTo: self.memoriesImage.centerXAnchor)
        let stackHCenterY = stackH.centerYAnchor.constraint(equalTo: self.memoriesImage.centerYAnchor, constant: 20.0)
        
        let constraints = [
            exitTop,
            exitBottom,
            exitLeading,
            exitTrailing,
            backTop,
            backBottom,
            backLeading,
            backTrailing,
            stackVCenterX,
            stackVCenterY,
            stackHCenterX,
            stackHCenterY
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
