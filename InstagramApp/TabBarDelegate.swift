//
//  TabBarDelegate.swift
//  InstagramApp
//
//  Created by Aviral on 30/03/22.
//  Copyright © 2022 Gwinyai Nyatsoka. All rights reserved.
//

import Foundation
import UIKit

class TabBarDelegate: NSObject{
    
}


extension TabBarDelegate: UITabBarControllerDelegate {
    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
////        let navigationController = viewController as? UINavigationController
////        _ = navigationController?.popViewController(animated: false)
//    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let selectedViewContoller = tabBarController.selectedViewController
        
        guard let _selectedViewContoller = selectedViewContoller else {
            return false
        }
        
        if _selectedViewContoller == viewController {
            return false
        }
        
        guard let contollerIndex = tabBarController.viewControllers?.firstIndex(of: viewController)else{
            return false
        }
        
        if contollerIndex == 2 {
            let newStoryPost = UIStoryboard(name: "NewPost", bundle: nil)
            let newPostVC = newStoryPost.instantiateViewController(withIdentifier: "NewPost") as! NewPostViewController
            let newViewNavigation = UINavigationController(rootViewController: newPostVC)
            newViewNavigation.modalPresentationStyle = .fullScreen
            _selectedViewContoller.present(newViewNavigation, animated: true)
            return false
        }
        
//        let navigationController = viewController as? UINavigationController
//        _ = navigationController?.popViewController(animated: false)
        return true
    }
    
}
