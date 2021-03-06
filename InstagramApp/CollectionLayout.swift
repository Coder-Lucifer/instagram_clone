//
//  CollectionLayout.swift
//  InstagramApp
//
//  Created by Aviral on 29/03/22.
//  Copyright © 2022 Gwinyai Nyatsoka. All rights reserved.
//

import Foundation
import UIKit

class CollectionLayout: UICollectionViewLayout {
    
    fileprivate var numberOfColumns:Int = 3
    
    fileprivate var cellPadding:CGFloat = 3
    
    fileprivate var cache: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    fileprivate var contentWidth: CGFloat{
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right) - (cellPadding * (CGFloat(numberOfColumns) - 1))
    }
    
    fileprivate var contentHeight: CGFloat = 0
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        
        let itemsPerRow: Int = 3
        let normalColumnWidth: CGFloat = contentWidth / CGFloat(itemsPerRow)
        let normalColumnHeight: CGFloat = normalColumnWidth
        
        let featuredColumnWidth: CGFloat = (normalColumnWidth * 2) + cellPadding
        let featuredColumnHeight: CGFloat = featuredColumnWidth
        
        var xOffsets: [CGFloat] = [CGFloat]()
        
        for item in 0..<6 {
            let multiplier = item % 3
//            print("MultiPlier:::: \(multiplier)")
            let xPos = CGFloat(multiplier) * (normalColumnWidth + cellPadding)
//            print("xPos:::: \(xPos)")
            xOffsets.append(xPos)
        }
        
        xOffsets.append(0.0)
        
        for _ in 0..<2 {
            xOffsets.append(featuredColumnWidth+cellPadding)
        }
        
        var yOffsets: [CGFloat] = [CGFloat]()
        
        
        for item in 0..<9 {
            
            var yPos = floor(Double(item/3)) * (Double(normalColumnHeight) + Double(cellPadding))
            
            if item == 8 {
                yPos += (Double(normalColumnHeight) + Double(cellPadding))
            }
            print("yPOS::::: \(yPos)")

            yOffsets.append(CGFloat(yPos))
        }
        
        let numberOfItemsPerSection:Int = 9
        
        let heightOfSection:CGFloat = 4 * normalColumnHeight + (4 * cellPadding)
//        print("Height Of Section:::: \(heightOfSection)")
        var itemInSection: Int = 0
        
//        print("Got xOffsets:::: \(xOffsets)")
//        print("Got yOffsets:::: \(yOffsets)")
        
        for item in 0..<collectionView.numberOfItems(inSection: 0){
            let indexPath = IndexPath(item: item, section: 0)
            let xPos = xOffsets[itemInSection]
            let multiplier:Double = floor(Double(item)/Double(numberOfItemsPerSection))
//            print("Multipliers:::: \(multiplier)")
            
            let yPos = yOffsets[itemInSection] + (heightOfSection * CGFloat(multiplier))
            print("Got New yPos::: \(yPos)")
            var cellWidth = normalColumnWidth
            var cellHeight = normalColumnHeight
            if (itemInSection + 1) % 7 == 0 && itemInSection != 0 {
                cellWidth = featuredColumnWidth
                cellHeight = featuredColumnHeight
            }
            let frame = CGRect(x: xPos, y: yPos, width: cellWidth, height: cellHeight)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cache.append(attributes)
            contentHeight = max(contentHeight, frame.maxY)
            itemInSection = itemInSection < (numberOfItemsPerSection - 1) ? (itemInSection + 1) : 0
        }
    
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attribute in cache {
            if attribute.frame.intersects(rect){
                visibleLayoutAttributes.append(attribute)
            }
        }
        
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
}
