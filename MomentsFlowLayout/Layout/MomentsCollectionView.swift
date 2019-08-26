//
//  MomentsCollectionView.swift
//  MomentsFlowLayout
//
//  Created by Nathan Hsu on 2019-08-24.
//  Copyright © 2019 Nathan Hsu. All rights reserved.
//

import UIKit

class MomentsCollectionView: UICollectionView {
    
    var highlightedCell: UICollectionViewCell?
    
    override func touchesShouldBegin(_ touches: Set<UITouch>, with event: UIEvent?, in view: UIView) -> Bool {
        if let cell = view.superview as? UICollectionViewCell {
            highlight(cell: cell)
        }
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let cell = highlightedCell {
            guard let indexPath = indexPath(for: cell) else { fatalError("indexPath nil")}
            guard let delegate = delegate else { fatalError("delegate nil")}
            
            selectItem(at: indexPath, animated: true, scrollPosition: [])
            delegate.collectionView?(self, didSelectItemAt: indexPath)
            
            unhighlight(cell: cell)
        }
        
    }
    
    func highlight(cell: UICollectionViewCell) {
        cell.isHighlighted = true
        highlightedCell = cell
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseOut], animations: {
            cell.contentView.transform = CGAffineTransform(scaleX: 0.965, y: 0.965)
        }) { (completed) in
            
        }
        
    }
    func unhighlight(cell: UICollectionViewCell) {
        cell.isHighlighted = false
        highlightedCell = nil
        
        UIView.animate(withDuration: 0.3) {
            cell.contentView.transform = CGAffineTransform.identity
        }
    }

}
