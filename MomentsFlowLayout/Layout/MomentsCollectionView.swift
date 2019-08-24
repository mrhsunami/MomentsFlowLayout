//
//  MomentsCollectionView.swift
//  MomentsFlowLayout
//
//  Created by Nathan Hsu on 2019-08-24.
//  Copyright © 2019 Nathan Hsu. All rights reserved.
//

import UIKit

class MomentsCollectionView: UICollectionView {
    
    override func touchesShouldBegin(_ touches: Set<UITouch>, with event: UIEvent?, in view: UIView) -> Bool {
        print(touches, event, view)
        return true
    }

}
