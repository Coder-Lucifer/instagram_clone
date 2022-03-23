//
//  HomeViewController.swift
//  InstagramApp
//
//  Created by Aviral on 22/03/22.
//  Copyright © 2022 Gwinyai Nyatsoka. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var posts: [Post] = {
        let model = Model()
        return model.postList
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = CGFloat(88.0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedTableViewCell")
        tableView.register(UINib(nibName: "StoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "StoriesTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        setupBarButtonItems()
    }
    

    func setupBarButtonItems(){
        let rightBarItemImage = UIImage(named: "send_nav_icon")
        rightBarItemImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightBarItemImage, style: .plain, target: nil, action: #selector(rightBarButtonItemTapped))
        let leftBarItemImage = UIImage(named: "camera_nav_icon")
        leftBarItemImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftBarItemImage, style: .plain, target: nil, action: #selector(leftBarButtonItemTapped))
        
        let profileImageView = UIImageView(image: UIImage(named: "logo_nav_icon"))
        self.navigationItem.titleView = profileImageView
    }

    
    @objc func rightBarButtonItemTapped(){
        
    }
    
    @objc func leftBarButtonItemTapped(){
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension HomeViewController: UITableViewDataSource,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count + 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoriesTableViewCell") as! StoriesTableViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell") as! FeedTableViewCell
            let currentIndex = indexPath.row - 1
            let postData = posts[currentIndex]
            cell.profileImage.image = postData.user.profileImage
            cell.postImage.image = postData.postImage
            cell.dateLabel.text = postData.datePosted
            cell.likeCountLabel.text = "\(postData.likesCount) Likes"
            cell.commentLabel.text = postData.postComment
            cell.userName.setTitle(postData.user.name, for: .normal)
            return cell
        }
    }
    
    
}
