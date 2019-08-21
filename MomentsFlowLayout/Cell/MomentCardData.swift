//
//  MomentCardData.swift
//  MomentsFlowLayout
//
//  Created by Nathan Hsu on 2019-08-20.
//  Copyright © 2019 Nathan Hsu. All rights reserved.
//

import UIKit

struct MomentCardData {
    let backgroundColor: UIColor
    let backgroundImage: UIImage
    let heading: String
    let caption: String
    let preferredCardLayout: MomentCardLayout?
}

struct MomentCardLayout {
    var textAlignment: CardTextAlignment = .left
    var headerAndCaptionVerticalCenterPercentage: CGFloat = 0.5 // percentage of height of card.
}

enum CardTextAlignment {
    case left, right
}
