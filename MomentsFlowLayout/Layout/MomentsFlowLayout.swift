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
    
    /// For use with `layoutAttributesForElements(in rect: CGRect)` to calculate 3D transforms
    var scaleOffset: CGFloat = 200
    var scaleFactor: CGFloat = 0.95
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(itemSize: CGSize) {
        super.init()
        self.itemSize = itemSize
        minimumLineSpacing = lineSpacing
        scrollDirection = .horizontal
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        /// A largerRect is needed since by the end of our 3D transforms, some cells that may be considered offscreen should actually end up showing on screen. Without this, cells "further back" on the visual stack does not consistently spawn at the right time.
        let largerRect = CGRect(x: rect.minX, y: rect.minY, width: rect.width * CGFloat(2), height: rect.height)
        
        guard let collectionView = self.collectionView else { fatalError("collectionView nil when requesting layoutAttributes") }
        guard let layoutAttributes = super.layoutAttributesForElements(in: largerRect) else { fatalError("unable to get layoutAttributes") }
        
        /// Calculate visibleRect and visibleCenterX
        let contentOffset = collectionView.contentOffset
        let size = collectionView.bounds.size
        let visibleRect = CGRect(x: contentOffset.x, y: contentOffset.y, width: size.width, height: size.height)
        let visibleCenterX = visibleRect.midX

        /// Apply transforms based on distance from visual center
        layoutAttributes.forEach {
            let distanceFromCenter = -(visibleCenterX - $0.center.x)
            let scale = distanceFromCenter * (self.scaleFactor - 1) / self.scaleOffset + 1
            let amountToShift: CGFloat = distanceFromCenter > 0 ? -distanceFromCenter * 0.85 : distanceFromCenter * 0.01
            let transform1 = CATransform3DTranslate(CATransform3DIdentity, amountToShift-16, 0, 0)
            let transform2 = CATransform3DScale(transform1, scale, scale, 0)
            $0.transform3D = transform2
            $0.zIndex = -$0.indexPath.row
        }
        
        return layoutAttributes
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        /// Prepare initial values
        guard let collectionView = self.collectionView else { fatalError("collectionView nil") }
        
        let proposedContentOffsetCenterX = proposedContentOffset.x + collectionView.bounds.width / 2
        let proposedRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.width, height: collectionView.bounds.height)
        
        guard let layoutAttributes = self.layoutAttributesForElements(in: proposedRect) else { fatalError("layoutAttributes nil") }
        
        /// Check all layoutAttributes and find the one closest to the center
        var candidateAttributes: UICollectionViewLayoutAttributes?
        for attributes in layoutAttributes {
            if attributes.representedElementCategory != .cell {
                continue
            }
            if candidateAttributes == nil {
                candidateAttributes = attributes
                continue
            }
            /// Check each attributes object and replaced the candidateAttributes variable if the one currently being checked has a center.x closer to the proposedContentOffsetCenterX
            if abs(attributes.center.x - proposedContentOffsetCenterX) < abs(candidateAttributes!.center.x - proposedContentOffsetCenterX) {
                candidateAttributes = attributes
            }
        }
        guard let aCandidateAttributes = candidateAttributes else {
            return proposedContentOffset
        }
        
        /// Calculate newOffsetX
        var newOffsetX = aCandidateAttributes.center.x - collectionView.bounds.size.width / 2
        
        /// Adjust newOffsetX to allow small flicks to advance at least a full page in the flick direction
        let offset = newOffsetX - collectionView.contentOffset.x
        if (velocity.x < 0 && offset > 0) || (velocity.x > 0 && offset < 0) {
            let pageWidth = itemSize.width + minimumLineSpacing
            newOffsetX += velocity.x > 0 ? pageWidth : -pageWidth
        }
        
        return CGPoint(x: newOffsetX, y: proposedContentOffset.y)
    }
    
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
