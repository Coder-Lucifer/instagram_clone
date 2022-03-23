//
//  StoriesTableViewCell.swift
//  InstagramApp
//
//  Created by Aviral on 22/03/22.
//  Copyright © 2022 Gwinyai Nyatsoka. All rights reserved.
//

import UIKit

class StoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var stories: [Story] = {
        let model = Model()
        return model.storyList
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = UITableViewCell.SelectionStyle.none
        collectionView.register(UINib(nibName: "StoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StoriesCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension StoriesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoriesCollectionViewCell", for: indexPath) as! StoriesCollectionViewCell
        cell.storyImage.image = stories[indexPath.row].post.postImage
        cell.userNameLabel.text = stories[indexPath.row].post.user.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 110)
    }
    
}
