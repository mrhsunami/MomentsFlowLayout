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
        
//        containerView.addSubview(startingView)
        
//        let copy = createCopy(of: cell)
//        copy.frame = presentationValue
//        let presentationCornerRadius = cell.contentView.layer.presentation()!.cornerRadius
//        copy.layer.cornerRadius = presentationCornerRadius
//        copy.layer.masksToBounds = true
        
        let toVC = transitionContext.viewController(forKey: .to)!
        let finalFrame = transitionContext.finalFrame(for: toVC)

//        toVC.view.isHidden = true
        toVC.view.isHidden = false
        
        containerView.addSubview(toVC.view)
        toVC.view.frame = startingView.frame
        toVC.view.layer.cornerRadius = startingView.layer.cornerRadius
        toVC.view.layer.masksToBounds = true
        toVC.view.layoutSubviews()
        
        let popUp = UIViewPropertyAnimator(duration: popUpDuration, dampingRatio: 0.75) {
//            startingView.frame = finalFrame
//            startingView.layer.cornerRadius = 0
            toVC.view.frame = finalFrame
            toVC.view.layer.cornerRadius = 0
//            toVC.view.layoutSubviews()
        }
        popUp.addCompletion { (position) in
            if position == .end {
//                startingView.removeFromSuperview()
                toVC.view.isHidden = false
                transitionContext.completeTransition(true)
            }
        }
        popUp.startAnimation()
    }

    // MARK - UIViewControllerTransitioningDelegate Methods
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }

}
