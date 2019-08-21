//
//  MomentsCardCell.swift
//  MomentsFlowLayout
//
//  Created by Nathan Hsu on 2019-08-17.
//  Copyright © 2019 Nathan Hsu. All rights reserved.
//

import UIKit

class MomentsCardCell: UICollectionViewCell {
    
    static let identifier = "momentsCard"
    var moment: MomentCardData?
    let imageView = UIImageView()
    let headerLabel = UILabel()
    let captionLabel = UILabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 25
        layer.masksToBounds = true /// By default, the corner radius does not apply to the image in the layer’s contents property; it applies only to the background color and border of the layer. However, setting the masksToBounds property to true causes the content to be clipped to the rounded corners.
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        contentView.addSubview(imageView)
        contentView.addSubview(headerLabel)
        contentView.addSubview(captionLabel)
    }
    func configure(with moment: MomentCardData) {
        self.moment = moment
        imageView.image = moment.backgroundImage
        headerLabel.text = moment.heading
        captionLabel.text = moment.caption
        layoutText(with: moment.preferredCardLayout)
    }
    func layoutText(with layout: MomentCardLayout?) {

        if let layout = layout {
            ///layout using provided layout
            /// 1. Figure out where vertical center is in view
            let textCenter = frame.height * layout.headerAndCaptionVerticalCenterPercentage
            let marginPercentage: CGFloat = 0.15
            /// 2. Constrain HeaderLabel bottom to line
            /// 3. Constrain Caption Lable to line
            headerLabel.translatesAutoresizingMaskIntoConstraints = false
            headerLabel.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: textCenter)
            captionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20)
            /// Create margins and constrain.
            
            /// 4. Constrain texts to leading or trailing margins by checking alignment
        } else {
            ///layout using default values
        }
        
        /// 1. Figure out where vertical center is in view
        /// 2. Constrain HeaderLabel bottom to line
        /// 3. Constrain Caption Lable to line
        /// 4. Constrain texts to leading or trailing margins by checking alignment
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
