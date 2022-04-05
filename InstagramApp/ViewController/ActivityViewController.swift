//
//  ActivityViewController.swift
//  InstagramApp
//
//  Created by Aviral on 22/03/22.
//  Copyright © 2022 Gwinyai Nyatsoka. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {


    @IBOutlet weak var segmentContoller: CustomSegmentView! {
        didSet{
            segmentContoller.delegate = self
        }
    }
    
    var currentIndex:Int = 0
    var deviceHeight:Double!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var slides:[ActivityView] = {
        let followingActivityData = FollowingActivityModel()
        let followingView = Bundle.main.loadNibNamed("ActivityView", owner: nil)?.first as! ActivityView
        followingView.activityData = followingActivityData.followingActivity
        let youActivityData = YouActivityModel()
        let youView = Bundle.main.loadNibNamed("ActivityView", owner: nil)?.first as! ActivityView
        youView.activityData = youActivityData.youActivity
        return [followingView,youView]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        deviceHeight = view.frame.height
        setupSlideScrollView(slides: slides)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    func setupSlideScrollView(slides:[ActivityView]){
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: deviceHeight)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: deviceHeight)
        scrollView.isPagingEnabled = true
        
        for i in 0..<slides.count {
            print("Height :::: \(deviceHeight)")
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: deviceHeight)
            scrollView.addSubview(slides[i])
        }
    }
}

extension ActivityViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        segmentContoller.updateSegementedControlSegs(index: currentIndex)
        currentIndex = Int(pageIndex)
    }
}

extension ActivityViewController: ActivityDelegate {
    func activityDidTouch() {
        print("activityDidTouch")
    }
    
    func scrollTo(index: Int) {
        if currentIndex == index {
            return
        }else{
            print("Heighthhhh :::: \(deviceHeight)")
            let pageWidth = self.view.frame.width
            let xPosition = pageWidth * CGFloat(index)
            scrollView.scrollRectToVisible(CGRect(x: xPosition, y: 0, width: pageWidth, height: self.scrollView.frame.height), animated: true)
        }
    }
}



