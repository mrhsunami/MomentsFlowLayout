//
//  MomentsCardCell.swift
//  MomentsFlowLayout
//
//  Created by Nathan Hsu on 2019-08-17.
//  Copyright © 2019 Nathan Hsu. All rights reserved.
//

import UIKit

struct MomentCardLayout {
    var textAlignment: NSTextAlignment = .left
    var headerAndCaptionVerticalCenterPercentage: CGFloat = 0.5 // percentage of height of card.
}

class MomentsCardCell: UICollectionViewCell {
    
    static let identifier = "momentsCard"
    var moment: MomentCardData?
    let imageView = UIImageView()
    let headerLabel = UILabel()
    var headerlabelConstraints: [NSLayoutConstraint] = []
    let captionLabel = UILabel()
    var captionLabelConstraints: [NSLayoutConstraint] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 25
        layer.masksToBounds = true /// By default, the corner radius does not apply to the image in the layer’s contents property; it applies only to the background color and border of the layer. However, setting the masksToBounds property to true causes the content to be clipped to the rounded corners.
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        contentView.addSubview(imageView)
        contentView.addSubview(headerLabel)
        contentView.addSubview(captionLabel)
        addTap(to: contentView)
    }
    
    func configure(with moment: MomentCardData) {
        self.moment = moment
        imageView.image = moment.backgroundImage
        headerLabel.text = moment.heading
        captionLabel.text = moment.caption
        layoutText(with: moment.preferredCardLayout)
//        if let layout = moment.preferredCardLayout {
//            layoutText(with: layout)
//        } else {
//            let layout = MomentCardLayout(textAlignment: .left, headerAndCaptionVerticalCenterPercentage: 0.5)
//            layoutText(with: layout)
//        }
    }
    
    func layoutText(with layout: MomentCardLayout?) {

        /// The parent function receives an optional layout which has to be unwrapped before passing the layout as an arguement to this internal layout function.
        func _layout(using layout: MomentCardLayout) {
            
            /// 1. Figure out where vertical center is in view
            let textCenter = frame.height * layout.headerAndCaptionVerticalCenterPercentage
            
            // Determines the left and right margins as a percentage of the width of the card cell's view.
            let marginPercentage: CGFloat = 0.10
            
            /// 2. Constrain HeaderLabel bottom to vertical center
            
            headerLabel.translatesAutoresizingMaskIntoConstraints = false
            
            // Contraints need to be deactivated each time a cell is configured as the layout of the cell will be different depending if it spawned to the left or right of the visible bounds of the scrollview since cells are large to the left, and smaller to the right. This is needed because the textCenter constant's calculation produces different results depending on the size. And to deactivate constratings, we need to store references to them outside of this scope
            NSLayoutConstraint.deactivate(headerlabelConstraints)
            headerlabelConstraints.removeAll()
            
            let bottomConstraint = NSLayoutConstraint(item: headerLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: textCenter)
            headerlabelConstraints.append(bottomConstraint)
            
            
            
            NSLayoutConstraint.activate(headerlabelConstraints)
            //            headerLabel.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: textCenter).isActive = true
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentView.frame.width * marginPercentage).isActive = true
            headerLabel.numberOfLines = 0
            headerLabel.sizeToFit() // This takes care of sizing the width and height so there's only now a need to be explicit about the position via autolayout.
            //            headerLabel.backgroundColor = .blue
            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(contentView.frame.width * marginPercentage)).isActive = true
            headerLabel.textAlignment = layout.textAlignment
            
            // Style the label
            headerLabel.font = UIFont.systemFont(ofSize: 29, weight: .bold)
            headerLabel.textColor = .white
            
            /// 3. Constrain Caption Lable to line
            captionLabel.translatesAutoresizingMaskIntoConstraints = false
            captionLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor).isActive = true
            captionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10).isActive = true
            captionLabel.sizeToFit()
            captionLabel.textAlignment = layout.textAlignment
            
            captionLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            captionLabel.textColor = .white
            
            
            //            captionLabel.backgroundColor = .blue
            //            captionLabel.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor).isActive = true
            //            captionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            /// Create margins and constrain.
            
            /// 4. Constrain texts to leading or trailing margins by checking alignment
        }
        
        if let layout = layout {
            _layout(using: layout)
        } else {
            let defaultLayout = MomentCardLayout(textAlignment: .left, headerAndCaptionVerticalCenterPercentage: 0.5)
            _layout(using: defaultLayout)
        }
        
       
        
        /// 1. Figure out where vertical center is in view
        /// 2. Constrain HeaderLabel bottom to line
        /// 3. Constrain Caption Lable to line
        /// 4. Constrain texts to leading or trailing margins by checking alignment
    }
    
    func addTap(to view: UIView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func onTap() {
        print("tapped")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
