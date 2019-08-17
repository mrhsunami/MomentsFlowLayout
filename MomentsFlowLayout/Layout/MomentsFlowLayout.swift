//
//  MomentsFlowLayout.swift
//  MomentsFlowLayout
//
//  Created by Nathan Hsu on 2019-08-17.
//  Copyright © 2019 Nathan Hsu. All rights reserved.
//

import UIKit

class MomentsFlowLayout: UICollectionViewFlowLayout {
    
    init(itemSize: CGSize) {
        super.init()
        self.itemSize = itemSize
        scrollDirection = .horizontal
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
