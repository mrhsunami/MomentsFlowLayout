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
        MomentCardData(backgroundColor: .darkGray, backgroundImage: UIImage(named: "demo3")!, heading: "Bring warmth outside", caption: "Discover", preferredCardLayout: MomentCardLayout(textAlignment: .left, headerAndCaptionVerticalCenterPercentage: 0.2)),
        MomentCardData(backgroundColor: .darkGray, backgroundImage: UIImage(named: "demo4")!, heading: "First Class Cabin", caption: "Discover", preferredCardLayout: MomentCardLayout(textAlignment: .left, headerAndCaptionVerticalCenterPercentage: 0.8)),
        MomentCardData(backgroundColor: .darkGray, backgroundImage: UIImage(named: "demo5")!, heading: "Perfect\nColor", caption: "Discover", preferredCardLayout: MomentCardLayout(textAlignment: .right, headerAndCaptionVerticalCenterPercentage: 0.2)),
        MomentCardData(backgroundColor: .darkGray, backgroundImage: UIImage(named: "demo6")!, heading: "Keep cool", caption: "Discover", preferredCardLayout: MomentCardLayout(textAlignment: .left, headerAndCaptionVerticalCenterPercentage: 0.3)),
        MomentCardData(backgroundColor: .darkGray, backgroundImage: UIImage(named: "demo7")!, heading: "Daylight Bright", caption: "Discover", preferredCardLayout: MomentCardLayout(textAlignment: .right, headerAndCaptionVerticalCenterPercentage: 0.18)),
        MomentCardData(backgroundColor: .darkGray, backgroundImage: UIImage(named: "demo8")!, heading: "Create\nwarmth", caption: "Discover", preferredCardLayout: MomentCardLayout(textAlignment: .center, headerAndCaptionVerticalCenterPercentage: 0.75))
    ]
}
