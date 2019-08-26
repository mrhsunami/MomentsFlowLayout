//
//  MomentStoriesViewController.swift
//  MomentsFlowLayout
//
//  Created by Nathan Hsu on 2019-08-22.
//  Copyright © 2019 Nathan Hsu. All rights reserved.
//

import UIKit

class MomentStoriesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
        setupDismissTapGesture()
        setupTransitioningDelegate()
    }
    
    func setupTransitioningDelegate() {
        
    }
    
    func setupDismissTapGesture() {
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        view.addGestureRecognizer(dismissTap)
    }
    
    @objc func onTap() {
        self.dismiss(animated: true, completion: nil)
    }

}
