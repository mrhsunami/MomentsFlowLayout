//
//  MomentsCollectionView.swift
//  MomentsFlowLayout
//
//  Created by Nathan Hsu on 2019-08-24.
//  Copyright © 2019 Nathan Hsu. All rights reserved.
//

import UIKit

class MomentsCollectionView: UICollectionView {
    
    var highlightedCell: MomentsCardCell?
    
    override func touchesShouldBegin(_ touches: Set<UITouch>, with event: UIEvent?, in view: UIView) -> Bool {
        
        if let cell = view.superview as? MomentsCardCell {
            highlight(cell: cell)
        }
        
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesEnded")
        if let cell = highlightedCell {
            self.selectItem(at: cell.indexPath, animated: true, scrollPosition: [])
            delegate?.collectionView?(self, didSelectItemAt: cell.indexPath!)
            unhighlight(cell: cell)
        }
        
    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let cell = highlightedCell {
//            unhighlight(cell: cell)
//        }
//    }
    
    func highlight(cell: MomentsCardCell) {
        guard let indexPath = cell.indexPath else { fatalError("cell indexPath is nil")}
        cell.isHighlighted = true
        highlightedCell = cell
        
        print("didHighlightItem at \(indexPath.row)")
        
        UIView.animate(withDuration: 0.3) {
            cell.contentView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
        
    }
    func unhighlight(cell: MomentsCardCell) {
        guard let indexPath = cell.indexPath else { fatalError("cell indexPath is nil")}
        cell.isHighlighted = false
        highlightedCell = nil
        
        print("didUnhighlightItem at \(indexPath.row)")
        
        UIView.animate(withDuration: 0.3) {
            cell.contentView.transform = CGAffineTransform.identity
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        print("touchesBegan")
//    }
    
    

}
