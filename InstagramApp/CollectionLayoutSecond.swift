//
//  CollectionLayoutSecond.swift
//  InstagramApp
//
//  Created by Aviral on 01/04/22.
//  Copyright © 2022 Gwinyai Nyatsoka. All rights reserved.
//

import Foundation
import UIKit


class CollectionLayoutSecond: UICollectionViewLayout {

    let numberOfItemsPerSection: Int = 6
    let numberOfColumn: Int = 3
    let cellPadding: CGFloat = 3

    fileprivate var cacheAttributes:[UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()

    fileprivate var contentWidth: CGFloat{
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right) - (cellPadding * (CGFloat(numberOfColumn) - 1))
    }

    fileprivate var contentHeight: CGFloat = 0

    fileprivate var normalCellSize:CGFloat {
        return contentWidth / CGFloat(numberOfColumn)
    }

    fileprivate var featuredCellSize:CGFloat {
        return (normalCellSize * 2) + cellPadding
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    
    override func prepare() {

        guard cacheAttributes.isEmpty == true, let collectionView = collectionView else{
            return
        }

        var xOffsets: [CGFloat] = [CGFloat]()
        var yOffsets: [CGFloat] = [CGFloat]()

        for item in 0..<numberOfItemsPerSection {
            if item < 4 {
                if item == 1 {
                    xOffsets.append(normalCellSize+cellPadding)
                }else {
                    xOffsets.append(0.0)
                }
            }else{
                xOffsets.append(featuredCellSize+cellPadding)
            }
        }

        for item in 0..<numberOfItemsPerSection {

            var yPos = floor(Double(item/3)*2) * (Double(normalCellSize) + Double(cellPadding))

            if item == 2 || item == 5 {
                yPos += (Double(normalCellSize) + Double(cellPadding))
            }

            yOffsets.append(CGFloat(yPos))
        }
        print("xOffsets::: \(xOffsets)")
        print("yOffsets::: \(yOffsets)")


        let heightOfSection = 4 * normalCellSize + (4 * cellPadding)
        var itemInSection = 0

        for item in 0..<collectionView.numberOfItems(inSection: 0){
            let indexPath = IndexPath(item: item, section: 0)
            let xPos = xOffsets[itemInSection]
//            let yPos = yOffsets[itemInSection]
            let multiplier:Double = floor(Double(item)/Double(numberOfItemsPerSection))
            let yPos = yOffsets[itemInSection] + (heightOfSection * CGFloat(multiplier))
            print("yPos ::: \(yPos)")
            var cellWidth = normalCellSize
            var cellHeight = normalCellSize
            if itemInSection  == 1 || itemInSection  == 3 {
                cellWidth = featuredCellSize
                cellHeight = featuredCellSize
            }
            let frame = CGRect(x: xPos, y: yPos, width: cellWidth, height: cellHeight)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cacheAttributes.append(attributes)
            contentHeight = max(contentHeight, frame.maxY)
            itemInSection = itemInSection < (numberOfItemsPerSection - 1) ? (itemInSection + 1) : 0
        }

    }


    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()

        for attribute in cacheAttributes {
            if attribute.frame.intersects(rect){
                visibleLayoutAttributes.append(attribute)
            }
        }

        return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheAttributes[indexPath.item]
    }

}


