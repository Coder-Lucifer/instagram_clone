//
//  NewPostPageViewController.swift
//  InstagramApp
//
//  Created by Aviral on 29/03/22.
//  Copyright © 2022 Gwinyai Nyatsoka. All rights reserved.
//

import UIKit

class NewPostPageViewController: UIPageViewController,UIPageViewControllerDelegate {
    
    var orderedViewControllers: [UIViewController] = [UIViewController]()
    
    var pagesToShow = NewPostPageToShow.pagesToShow()
    
    var currentIndex: Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        
        for page in pagesToShow {
            let pageContoller = newPageToShow(pageToShow: page)
            orderedViewControllers.append(pageContoller)
        }
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(pageChanged(notification:)), name: NSNotification.Name("newPage"), object: nil)
    }
    
    
    @objc func pageChanged(notification:NSNotification){
        if let receivedObject = notification.object as? NewPostPageToShow {
            print("Clicked \(receivedObject)")
            switch receivedObject {
            case .library:
                showViewController(index: 0)
            case .camera:
                showViewController(index: 1)
            }
        }
    }
    
    private func newPageToShow(pageToShow:NewPostPageToShow) -> UIViewController {
        
        var viewController: UIViewController!
        
        let newPostStroyBoard = UIStoryboard(name: "NewPost", bundle: nil)
        
        switch pageToShow {
        case .library:
            viewController = newPostStroyBoard.instantiateViewController(withIdentifier: pageToShow.identifier) as! LibraryPageViewController
        case .camera:
            viewController = newPostStroyBoard.instantiateViewController(withIdentifier: pageToShow.identifier) as! CameraPageViewController
        }
        
        return viewController
                
    }
    
    func showViewController(index:Int){
        
        if currentIndex > index {
            setViewControllers([orderedViewControllers[index]], direction: .reverse, animated: true)
        }else if currentIndex < index{
            setViewControllers([orderedViewControllers[index]], direction: .forward, animated: true)
        }
        currentIndex = index
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("newPage"), object: nil)
    }
    

}

extension NewPostPageViewController: UIPageViewControllerDataSource{

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of:viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        return orderedViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else{
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let orderViewCount = orderedViewControllers.count
        guard nextIndex != orderViewCount else {
            return nil
        }
        guard orderViewCount > nextIndex else {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }

}
