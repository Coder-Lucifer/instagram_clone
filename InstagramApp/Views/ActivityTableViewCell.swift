//
//  ActivityTableViewCell.swift
//  InstagramApp
//
//  Created by Aviral on 04/04/22.
//  Copyright © 2022 Gwinyai Nyatsoka. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var textView: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.masksToBounds = false
        selectionStyle = .none
    }
    
    
    override func layoutSubviews() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    
}
