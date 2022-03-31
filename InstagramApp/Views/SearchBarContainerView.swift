//
//  SearchBarContainerView.swift
//  InstagramApp
//
//  Created by Aviral on 29/03/22.
//  Copyright © 2022 Gwinyai Nyatsoka. All rights reserved.
//

import UIKit

class SearchBarContainerView: UIView {
    let searchBar: UISearchBar
    
    init(customSearchBar:UISearchBar){
        searchBar = customSearchBar
        super.init(frame: CGRect.zero)
        addSubview(searchBar)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience override init(frame:CGRect){
        self.init(customSearchBar:UISearchBar())
        self.frame = frame
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = bounds
    }
}
