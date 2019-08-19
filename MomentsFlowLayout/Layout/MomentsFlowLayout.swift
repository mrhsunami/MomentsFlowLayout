//
//  MomentsFlowLayout.swift
//  MomentsFlowLayout
//
//  Created by Nathan Hsu on 2019-08-17.
//  Copyright © 2019 Nathan Hsu. All rights reserved.
//

import UIKit

class MomentsFlowLayout: UICollectionViewFlowLayout {
    
    var previousCollectionViewSize: CGSize = CGSize.zero
    
    var lineSpacing: CGFloat = 25
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(itemSize: CGSize) {
        super.init()
        self.itemSize = itemSize
        minimumLineSpacing = lineSpacing
        scrollDirection = .horizontal
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = self.collectionView else { fatalError("collectionView nil") }
        
        let proposedRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.width, height: collectionView.bounds.height)
        guard let layoutAttributes = self.layoutAttributesForElements(in: proposedRect) else {
            return proposedContentOffset
        }
        
        var candidateAttributes: UICollectionViewLayoutAttributes?
        let proposedContentOffsetCenterX = proposedContentOffset.x + collectionView.bounds.width / 2
        
        for attributes in layoutAttributes {
            if attributes.representedElementCategory != .cell {
                continue
            }
            
            if candidateAttributes == nil {
                candidateAttributes = attributes
                continue
            }
            
            if abs(attributes.center.x - proposedContentOffsetCenterX) < abs(candidateAttributes!.center.x - proposedContentOffsetCenterX) {
                candidateAttributes = attributes
            }
        }
        
        guard let aCandidateAttributes = candidateAttributes else {
            return proposedContentOffset
        }
        
        var newOffsetX = aCandidateAttributes.center.x - collectionView.bounds.size.width / 2
        let offset = newOffsetX - collectionView.contentOffset.x
        
        if (velocity.x < 0 && offset > 0) || (velocity.x > 0 && offset < 0) {
            let pageWidth = itemSize.width + minimumLineSpacing
            newOffsetX += velocity.x > 0 ? pageWidth : -pageWidth
        }
        
        return CGPoint(x: newOffsetX, y: proposedContentOffset.y)
        
    }
    
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        var attributes: [UICollectionViewLayoutAttributes] = []
//        return attributes
//    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        super.invalidateLayout(with: context)
        
        guard let collectionView = self.collectionView else { fatalError("collectionView nil") }
        
        if collectionView.bounds.size != previousCollectionViewSize {
            previousCollectionViewSize = collectionView.bounds.size
            configureContentInset()
        }
        
    }
    
    /// This takes into account item width to assure that cells are centered when scrolled to either ends of the collection view's scroll view
    func configureContentInset() {
        guard let collectionView = self.collectionView else { fatalError("collectionView nil") }
        let horizontalInset = (collectionView.bounds.size.width - itemSize.width) / 2
        let topInset = 0.086 * collectionView.frame.height // 0.086 is derived from 70/812 (812 height of Xs). This means the top should be shifted down by 8.6% of the device's screen height
        collectionView.contentInset = UIEdgeInsets.init(top: topInset, left: horizontalInset, bottom: 0, right: horizontalInset)
    }
    

    
}
