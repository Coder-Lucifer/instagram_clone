//
//  CameraPageViewController.swift
//  InstagramApp
//
//  Created by Aviral on 29/03/22.
//  Copyright © 2022 Gwinyai Nyatsoka. All rights reserved.
//

import UIKit

class CameraPageViewController: UIViewController {

    @IBOutlet weak var simpleCameraView: SimpleCameraView!
    
    var simpleCamera:SimpleCamera!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        simpleCamera = SimpleCamera(cameraView: simpleCameraView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        simpleCamera.startSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        simpleCamera.stopSession()
    }
    
    @IBAction func cameraCaptureClicked(_ sender: Any) {
        if simpleCamera.currentCaptureMode == .photo {
            simpleCamera.takePhoto { data, success in
                print("Image Clicked")
            }
        }
    }

}
