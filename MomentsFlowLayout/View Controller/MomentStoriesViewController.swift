//
//  MomentStoriesViewController.swift
//  MomentsFlowLayout
//
//  Created by Nathan Hsu on 2019-08-22.
//  Copyright © 2019 Nathan Hsu. All rights reserved.
//

import UIKit

class MomentStoriesViewController: UIViewController {

    var moment: MomentCardData? {
        didSet {
            if let moment = moment {
                applyMomentData(from: moment)
            }
        }
    }
    
    private let imageView = UIImageView()
    private let headerLabel = UILabel()
    private var headerlabelConstraints: [NSLayoutConstraint] = []
    private let captionLabel = UILabel()
    private var captionLabelConstraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDismissTapGesture()
        
        view.addSubview(imageView)
        view.addSubview(headerLabel)
        view.addSubview(captionLabel)
        
        layoutImageView()
    }
    
    private func setupDismissTapGesture() {
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        view.addGestureRecognizer(dismissTap)
    }
    
    @objc private func onTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func applyMomentData(from moment: MomentCardData) {
        imageView.image = moment.backgroundImage
        headerLabel.text = moment.heading
        captionLabel.text = moment.caption
    }
    
    private func layoutImageView() {
        imageView.frame = view.frame
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        imageView.contentMode = .scaleAspectFill
    }
    
    private func layoutText(with layout: MomentCardLayout?) {
        
        /// The parent function receives an optional layout which has to be unwrapped before passing the layout as an arguement to this internal layout function.
        func _layout(using layout: MomentCardLayout) {
            
            /// 1. Figure out where vertical center is in view
            let textCenter = view.bounds.height * layout.headerAndCaptionVerticalCenterPercentage // needs to use bounds.height not frame.height as the frame's height is inaccurate for cells spawning to the right of the scrollview's visible bounds. The 3D transform in the MomentsFlowLayout code gets called first before cellForItem gets called which means this gets called after as well.
            
            // Determines the left and right margins as a percentage of the width of the card cell's view.
            let sideMargin: CGFloat = {
                return view.bounds.width * 0.11
            }()
            
            /// 2. Constrain headerLabel bottom to vertical center
            
            headerLabel.translatesAutoresizingMaskIntoConstraints = false
            
            // Contraints need to be deactivated each time a cell is configured as the layout of the cell will be different depending if it spawned to the left or right of the visible bounds of the scrollview since cells are large to the left, and smaller to the right. This is needed because the textCenter constant's calculation produces different results depending on the size. And to deactivate constratings, we need to store references to them outside of this scope
            NSLayoutConstraint.deactivate(headerlabelConstraints)
            headerlabelConstraints.removeAll()
            
            headerLabel.textAlignment = layout.textAlignment
            headerLabel.numberOfLines = 0
            
            let bottomConstraint = NSLayoutConstraint(item: headerLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: textCenter)
            let leadingConstraint = NSLayoutConstraint(item: headerLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: sideMargin)
            let trailingConstraint = NSLayoutConstraint(item: headerLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -(sideMargin))
            headerlabelConstraints.append(contentsOf: [bottomConstraint, leadingConstraint, trailingConstraint])
            
            NSLayoutConstraint.activate(headerlabelConstraints)
            
            // Style the label
            headerLabel.font = UIFont.systemFont(ofSize: 29, weight: .bold)
            headerLabel.textColor = .white
            
            /// 3. Constrain captionLabel to line
            captionLabel.translatesAutoresizingMaskIntoConstraints = false
            
            captionLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor).isActive = true
            captionLabel.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor).isActive = true
            captionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10).isActive = true
            
            captionLabel.textAlignment = layout.textAlignment
            
            captionLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            captionLabel.textColor = .white
            
        }
        
        if let layout = layout {
            _layout(using: layout)
        } else {
            let defaultLayout = MomentCardLayout(textAlignment: .left, headerAndCaptionVerticalCenterPercentage: 0.5)
            _layout(using: defaultLayout)
        }
        
    }
    
}
