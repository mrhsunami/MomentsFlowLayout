//
//  AutolayoutHelpers.swift
//  MomentsFlowLayout
//
//  Created by Nathan Hsu on 2019-08-26.
//  Copyright © 2019 Nathan Hsu. All rights reserved.
//

import UIKit

extension UIView {
    func edges(to view: UIView, top: CGFloat=0, left: CGFloat=0, bottom: CGFloat=0, right: CGFloat=0) {
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: right),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
            ])
    }
}
