//
//  SearchViewController.swift
//  InstagramApp
//
//  Created by Aviral on 22/03/22.
//  Copyright © 2022 Gwinyai Nyatsoka. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchContoller : UISearchController!
    
    lazy var posts: [Post] = {
        let model = Model()
        return model.postList
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchContoller = UISearchController(searchResultsController: nil)
        searchContoller.obscuresBackgroundDuringPresentation = true
        searchContoller.searchBar.showsCancelButton = false
        
        for subView in searchContoller.searchBar.subviews {
            for subView1 in subView.subviews {
                if let textField = subView1 as? UITextField {
                    textField.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.0)
                    textField.textAlignment = NSTextAlignment.center
                }
            }
        }
        
        searchContoller.dimsBackgroundDuringPresentation = false
        searchContoller.definesPresentationContext = true
        searchContoller.hidesNavigationBarDuringPresentation = false
        
        let searchBarContainer = SearchBarContainerView(customSearchBar: searchContoller.searchBar)
        searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        navigationItem.titleView = searchBarContainer
    }
    
}


extension SearchViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCollectionViewCell", for: indexPath) as! ExploreCollectionViewCell
        cell.exploreImage.image = posts[indexPath.row].postImage
        return cell
    }
    
}
