//
//  StoriesCollectionViewCell.swift
//  InstagramApp
//
//  Created by Aviral on 22/03/22.
//  Copyright © 2022 Gwinyai Nyatsoka. All rights reserved.
//

import UIKit

class StoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var storyImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        storyImage.layer.cornerRadius = storyImage.frame.width / 2
        storyImage.layer.masksToBounds = true
        storyImage.layer.borderColor = UIColor.white.cgColor
        storyImage.layer.borderWidth = CGFloat(3.0)
    }

}
