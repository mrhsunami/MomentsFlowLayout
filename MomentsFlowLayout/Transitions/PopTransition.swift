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
    var transitionType = TransitionType.present
    var startingCardFrame: CGRect?
    var startingCardCornerRadius: CGFloat?
    var endingCardFrameAtDismissal: CGRect?
    var presentedCell: UICollectionViewCell?
    
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
    
        guard let startingCardFrame = startingCardFrame else { fatalError("startingCardFrame nil") }
        guard let startingCardCornerRadius = startingCardCornerRadius else { fatalError("cornerRadius nil") }
        guard let endingCardFrame = endingCardFrameAtDismissal else { fatalError("endingCardFrame nil") }
    
        switch transitionType {
        case .present:
            let toVC = transitionContext.viewController(forKey: .to)!
            guard let toView = toVC.view else { fatalError("toView nil")}
            
            let startFrame = startingCardFrame
            let finalFrame = transitionContext.finalFrame(for: toVC)
            
            containerView.addSubview(toVC.view)
            toView.frame = startFrame
            toView.layer.cornerRadius = startingCardCornerRadius
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
        case .dismiss:
            guard let fromVC = transitionContext.viewController(forKey: .from) else { fatalError("fromVC nil") }
            guard let fromView = fromVC.view else { fatalError("fromView nil") }
            guard let toVC = transitionContext.viewController(forKey: .to) else { fatalError("toVC nil") }
            guard let toView = toVC.view else { fatalError("toView nil")}
            guard let presentedCell = presentedCell else { fatalError("presentedCell nil") }
            
            containerView.addSubview(toView)
            containerView.addSubview(fromView)
            presentedCell.isHidden = true
            toView.frame = transitionContext.finalFrame(for: toVC)
            
            let popDown = UIViewPropertyAnimator(duration: popDownDuration, dampingRatio: 0.75) {
                fromView.frame = endingCardFrame
                fromView.layer.cornerRadius = startingCardCornerRadius
            }
            popDown.addCompletion { (position) in
                if position == .end {
                    presentedCell.isHidden = false
                    transitionContext.completeTransition(true)
                }
            }
            popDown.startAnimation()
        }
        
        
    }

    // MARK - UIViewControllerTransitioningDelegate Methods
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionType = .present
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionType = .dismiss
        return self
    }
    

}
