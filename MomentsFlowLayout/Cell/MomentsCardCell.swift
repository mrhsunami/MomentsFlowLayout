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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 25
        layer.masksToBounds = true /// By default, the corner radius does not apply to the image in the layer’s contents property; it applies only to the background color and border of the layer. However, setting the masksToBounds property to true causes the content to be clipped to the rounded corners.
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
