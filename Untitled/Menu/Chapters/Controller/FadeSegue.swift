//
//  FadeSegue.swift
//  Untitled
//
//  Created by Gabriel Ferreira on 29/10/20.
//

import UIKit

class FadeSegue: UIStoryboardSegue {
    override func perform() {
        self.destination.transitioningDelegate = self
        super.perform()
    }
}

extension FadeSegue: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadePresentAnimator()
    }
}

class FadePresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        
        if let tv = toView {
            transitionContext.containerView.addSubview(tv)
        }
        
        toView?.alpha = 0.0
        toView?.layoutIfNeeded()
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration) {
            fromView?.alpha = 0.0
            fromView?.layoutIfNeeded()
        } completion: { (finished) in
            UIView.animate(withDuration: duration) {
                toView?.alpha = 1.0
                toView?.layoutIfNeeded()
            } completion: { (finished) in
                transitionContext.completeTransition(true)
            }
            transitionContext.completeTransition(true)
        }
        
        

    }
}
