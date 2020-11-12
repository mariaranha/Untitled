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
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeBackPresentAnimator()
    }
}

class FadePresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        let fromVC = transitionContext.viewController(forKey: .from)
        
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
            }
            if let vc = fromVC as? NarrativeViewController {
                vc.view.alpha = 0.0
            }else {
                fromView?.alpha = 1.0
            }
            transitionContext.completeTransition(true)
        }
    }
}
class FadeBackPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        let toVC = transitionContext.viewController(forKey: .to)
        
        if let tv = toView {
            transitionContext.containerView.addSubview(tv)
        }
        
        toView?.alpha = 0.0
        toView?.layoutIfNeeded()
        
        let duration = transitionDuration(using: transitionContext)
        if let _ = toVC as? NarrativeViewController {
            UIView.animate(withDuration: duration) {
                fromView?.alpha = 0.0
                fromView?.layoutIfNeeded()
            }completion: { (finished) in
                transitionContext.completeTransition(true)
            }
        }else{
            UIView.animate(withDuration: duration) {
                fromView?.alpha = 0.0
                fromView?.layoutIfNeeded()
            } completion: { (finished) in
                UIView.animate(withDuration: duration) {
                    toView?.alpha = 1.0
                    toView?.layoutIfNeeded()
                }
                fromView?.alpha = 1.0
                
                transitionContext.completeTransition(true)
            }
        }
    }
}
