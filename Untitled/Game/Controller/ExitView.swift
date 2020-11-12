//
//  ExitView.swift
//  Untitled
//
//  Created by Gabriel Ferreira on 10/11/20.
//

import Foundation
import UIKit

class ExitView: UIView {
    public var delegate: UIViewController? {
        didSet {
            self.setConstraints()
        }
    }
    public var dismiss : (() -> Void)?
    public var cancel : (() -> Void)?
    
    private var backView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .black
        view.alpha = 0.5
        
        return view
    }()
    public var exitButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "confirm_button.png")
        
        btn.setImage(img, for: .normal)
        
        return btn
    }()
    public var cancelButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "cancel_button.png")
        
        btn.setImage(img, for: .normal)
        
        return btn
    }()
    public var messageImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "board_leave.png")
                
        return img
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = .clear
        
        self.exitButton.addTarget(self, action: #selector(exitAction), for: .touchUpInside)
        self.cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
    }
    
    @objc func exitAction() {
        self.dismiss?()
    }
    
    @objc func cancelAction() {
        self.cancel?()
    }
    
    func setConstraints() {
        let stackH = UIStackView(arrangedSubviews: [self.cancelButton, self.exitButton])
        let stackV = UIStackView(arrangedSubviews: [self.messageImage, stackH])
        stackH.axis = .horizontal
        stackV.axis = .vertical
        stackV.alignment = .center
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backView.translatesAutoresizingMaskIntoConstraints = false
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
        let stackCenterX = stackV.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let stackCenterY = stackV.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        let constraints = [
            exitTop,
            exitBottom,
            exitLeading,
            exitTrailing,
            backTop,
            backBottom,
            backLeading,
            backTrailing,
            stackCenterX,
            stackCenterY
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
