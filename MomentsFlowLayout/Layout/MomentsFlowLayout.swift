//
//  MomentsFlowLayout.swift
//  MomentsFlowLayout
//
//  Created by Nathan Hsu on 2019-08-17.
//  Copyright © 2019 Nathan Hsu. All rights reserved.
//

import UIKit

class MomentsFlowLayout: UICollectionViewLayout {
    
    var previousCollectionViewSize: CGSize = CGSize.zero
    
    /// UICollectionViewFlowLayout Properties
    var itemSize = CGSize.zero
    var minimumLineSpacing: CGFloat = 0
    
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
    }
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = self.collectionView else {
            return CGSize.zero
        }
        let itemCount = collectionView.numberOfItems(inSection: 0)
        let contentSize = CGSize(width: CGFloat(itemCount) * (itemSize.width + lineSpacing), height: collectionView.bounds.height)
        return contentSize
    }
    
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//
//        /// Prepare initial values
//        guard let collectionView = self.collectionView else { fatalError("collectionView nil") }
//
//        let proposedContentOffsetCenterX = proposedContentOffset.x + collectionView.bounds.width / 2
//        let proposedRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.width, height: collectionView.bounds.height)
//
//        guard let layoutAttributes = self.layoutAttributesForElements(in: proposedRect) else { fatalError("layoutAttributes nil") }
//
//        /// Check all layoutAttributes and find the one closest to the center
//        var candidateAttributes: UICollectionViewLayoutAttributes?
//        for attributes in layoutAttributes {
//            if attributes.representedElementCategory != .cell {
//                continue
//            }
//            if candidateAttributes == nil {
//                candidateAttributes = attributes
//                continue
//            }
//            /// Check each attributes object and replaced the candidateAttributes variable if the one currently being checked has a center.x closer to the proposedContentOffsetCenterX
//            if abs(attributes.center.x - proposedContentOffsetCenterX) < abs(candidateAttributes!.center.x - proposedContentOffsetCenterX) {
//                candidateAttributes = attributes
//            }
//        }
//        guard let aCandidateAttributes = candidateAttributes else {
//            return proposedContentOffset
//        }
//
//        /// Calculate newOffsetX
//        var newOffsetX = aCandidateAttributes.center.x - collectionView.bounds.size.width / 2
//
//        /// Adjust newOffsetX to allow small flicks to advance at least a full page in the flick direction
//        let offset = newOffsetX - collectionView.contentOffset.x
//        if (velocity.x < 0 && offset > 0) || (velocity.x > 0 && offset < 0) {
//            let pageWidth = itemSize.width + minimumLineSpacing
//            newOffsetX += velocity.x > 0 ? pageWidth : -pageWidth
//        }
//
//        return CGPoint(x: newOffsetX, y: proposedContentOffset.y)
//    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = CGRect(x: CGFloat(indexPath.row)*(itemSize.width + lineSpacing), y: 70, width: itemSize.width, height: itemSize.height)
        return attributes
    }
    
    var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    override func prepare() {
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        for i in 0..<itemCount {
            let indexPath = IndexPath(row: i, section: 0)
            if let attribute = layoutAttributesForItem(at: indexPath) {
                layoutAttributes.append(attribute)
            }
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let ourCollectionView = self.collectionView else { return nil }
        
        let largerRect = CGRect(x: 0, y: 0, width: 20000, height: ourCollectionView.frame.height)
        
        guard let collectionView = self.collectionView else { fatalError("collectionView nil") }
//        guard let superAttributes = super.layoutAttributesForElements(in: largerRect) else { return super.layoutAttributesForElements(in: largerRect) }
        
        let contentOffset = collectionView.contentOffset
        let size = collectionView.bounds.size
        let visibleRect = CGRect(x: contentOffset.x, y: contentOffset.y, width: size.width, height: size.height)
        let visibleCenterX = visibleRect.midX
        
//        guard case let newAttributesArray as [UICollectionViewLayoutAttributes] = NSArray(array: superAttributes, copyItems: true) else { return nil }
        let newAttributesArray = layoutAttributes
        
        let filteredArray = newAttributesArray.filter { (attributes) -> Bool in
            attributes.frame.intersects(rect)
        }
        
//        newAttributesArray.forEach {
//            let distanceFromCenter = -(visibleCenterX - $0.center.x)
//            let scale = distanceFromCenter * (self.scaleFactor - 1) / self.scaleOffset + 1
//            let amountToShift: CGFloat = distanceFromCenter > 0 ? -distanceFromCenter * 0.85 : distanceFromCenter * 0.01
//            let transform1 = CATransform3DTranslate(CATransform3DIdentity, amountToShift-16, 0, 0)
//            let transform2 = CATransform3DScale(transform1, scale, scale, 0)
//            $0.transform3D = transform2
//            $0.zIndex = -$0.indexPath.row
//        }
        
        return filteredArray
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
