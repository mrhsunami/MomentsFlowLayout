//
//  DemoDataStore.swift
//  MomentsFlowLayout
//
//  Created by Nathan Hsu on 2019-08-23.
//  Copyright © 2019 Nathan Hsu. All rights reserved.
//

import UIKit

class DemoDataStore {
    static let momentsData: [MomentCardData] = [
        MomentCardData(backgroundColor: .darkGray, backgroundImage: UIImage(named: "demo1")!, heading: "Relax. \nOne touch.\nAll the lights.", caption: "Discover", preferredCardLayout: MomentCardLayout(textAlignment: .left, headerAndCaptionVerticalCenterPercentage: 0.8)),
        MomentCardData(backgroundColor: .darkGray, backgroundImage: UIImage(named: "demo2")!, heading: "Wake up \nto your own sunrise.", caption: "Discover", preferredCardLayout: MomentCardLayout(textAlignment: .left, headerAndCaptionVerticalCenterPercentage: 0.3)),
        MomentCardData(backgroundColor: .darkGray, backgroundImage: UIImage(named: "demo3")!, heading: "Bring the warmth outdoor", caption: "Discover", preferredCardLayout: MomentCardLayout(textAlignment: .left, headerAndCaptionVerticalCenterPercentage: 0.22)),
        MomentCardData(backgroundColor: .darkGray, backgroundImage: UIImage(named: "demo4")!, heading: "First Class Cabin", caption: "Virgin Airline would be proud.", preferredCardLayout: MomentCardLayout(textAlignment: .left, headerAndCaptionVerticalCenterPercentage: 0.7)),
        MomentCardData(backgroundColor: .darkGray, backgroundImage: UIImage(named: "demo5")!, heading: "Relax", caption: "One Touch, All the lights", preferredCardLayout: MomentCardLayout(textAlignment: .right, headerAndCaptionVerticalCenterPercentage: 0.7)),
        MomentCardData(backgroundColor: .darkGray, backgroundImage: UIImage(named: "demo6")!, heading: "Relax", caption: "One Touch, All the lights", preferredCardLayout: nil),
        MomentCardData(backgroundColor: .darkGray, backgroundImage: UIImage(named: "demo7")!, heading: "Relax", caption: "One Touch, All the lights", preferredCardLayout: MomentCardLayout(textAlignment: .left, headerAndCaptionVerticalCenterPercentage: 0.7)),
        MomentCardData(backgroundColor: .darkGray, backgroundImage: UIImage(named: "demo8")!, heading: "Relax", caption: "One Touch, All the lights", preferredCardLayout: MomentCardLayout(textAlignment: .right, headerAndCaptionVerticalCenterPercentage: 0.7))
    ]
}
