//
//  ActivityView.swift
//  InstagramApp
//
//  Created by Aviral on 04/04/22.
//  Copyright © 2022 Gwinyai Nyatsoka. All rights reserved.
//

import UIKit

class ActivityView: UIView {

    @IBOutlet weak var tableView: UITableView!
    
    var activityData: [Activity] = [Activity]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "ActivityTableViewCell")
    }
}


extension ActivityView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80.0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityTableViewCell") as! ActivityTableViewCell
        let activity = activityData[indexPath.row]
        cell.profileImageView.image = activity.userImage
        cell.textView.text = activity.details
        return cell
    }
    
    
}
