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
    public typealias dismissTypelias = () -> Void
    public var dismiss : dismissTypelias?
    private var backView = UIView()
    public var exitButton: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("Fechar", for: .normal)
        
        return btn
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = .clear
        self.backView.backgroundColor = .black
        self.backView.alpha = 0.3
        
        self.exitButton.addTarget(self, action: #selector(exitAction), for: .touchUpInside)
    }
    
    @objc func exitAction() {
        self.dismiss?()
    }
    
    func setConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backView.translatesAutoresizingMaskIntoConstraints = false
        self.exitButton.translatesAutoresizingMaskIntoConstraints = false
        self.delegate?.view.addSubview(self)
        self.addSubview(self.backView)
        self.addSubview(self.exitButton)
        
        let exitTop = self.topAnchor.constraint(equalTo: self.delegate!.view.topAnchor)
        let exitBottom = self.bottomAnchor.constraint(equalTo: self.delegate!.view.bottomAnchor)
        let exitLeading = self.leadingAnchor.constraint(equalTo: self.delegate!.view.leadingAnchor)
        let exitTrailing = self.trailingAnchor.constraint(equalTo: self.delegate!.view.trailingAnchor)
        let backTop = self.backView.topAnchor.constraint(equalTo: self.topAnchor)
        let backBottom = self.backView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        let backLeading = self.backView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let backTrailing = self.backView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        let buttonCenterX = self.exitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let buttonCenterY = self.exitButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let buttonHeight = self.exitButton.heightAnchor.constraint(equalToConstant: 60.0)
        let buttonWidth = self.exitButton.heightAnchor.constraint(equalToConstant: 100.0)
        
        let constraints = [
            exitTop,
            exitBottom,
            exitLeading,
            exitTrailing,
            backTop,
            backBottom,
            backLeading,
            backTrailing,
            buttonCenterX,
            buttonCenterY,
            buttonHeight,
            buttonWidth
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
