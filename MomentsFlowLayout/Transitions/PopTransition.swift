//
//  PopTransition.swift
//  MomentsFlowLayout
//
//  Created by Nathan Hsu on 2019-08-26.
//  Copyright © 2019 Nathan Hsu. All rights reserved.
//

import UIKit

class PopTransition: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {

    enum TransitionType {
        case present
        case dismiss
    }
    
    let popUpDuration: Double = 0.35
    let popDownDuration: Double = 0.3
    var transitionType = TransitionType.dismiss
    var startingView: UIView?
    
    // MARK - UIViewControllerAnimatedTransitioning Methods
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        switch transitionType {
        case .present:
            return popUpDuration
        case .dismiss:
            return popDownDuration
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
    
        guard let startingView = startingView else { fatalError("startingView nil")}
        
        let toVC = transitionContext.viewController(forKey: .to)!
        guard let toView = toVC.view else { fatalError("toView nil")}
        
        let startFrame = startingView.frame
        let finalFrame = transitionContext.finalFrame(for: toVC)

        containerView.addSubview(toVC.view)
        toView.frame = startFrame
        toView.layer.cornerRadius = startingView.layer.cornerRadius
        toView.layer.masksToBounds = true
        toView.layoutSubviews()
        
        let popUp = UIViewPropertyAnimator(duration: popUpDuration, dampingRatio: 0.75) {
            toView.frame = finalFrame
            toView.layer.cornerRadius = 0
        }
        popUp.addCompletion { (position) in
            if position == .end {
                transitionContext.completeTransition(true)
            }
        }
        popUp.startAnimation()
    }

    // MARK - UIViewControllerTransitioningDelegate Methods
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return self
//    }

}
