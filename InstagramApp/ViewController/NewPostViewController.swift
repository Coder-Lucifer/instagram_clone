//
//  NewPostViewController.swift
//  InstagramApp
//
//  Created by Aviral on 22/03/22.
//  Copyright © 2022 Gwinyai Nyatsoka. All rights reserved.
//

import UIKit

enum NewPostPageToShow {
    
    case library,camera
    
    var identifier:String {
        switch self {
        case .library:
            return "LibraryPageViewController"
        case .camera:
            return "CameraPageViewController"
        }
    }
    
    static func pagesToShow() -> [NewPostPageToShow] {
        return [.library,.camera]
    }
}

class NewPostViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonDidPressed))
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func cancelButtonDidPressed(){
        dismiss(animated: true,completion: nil)
    }
    
    
    @IBAction func libraryButtonDidPressed(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPage"), object: NewPostPageToShow.library)
    }
    
    @IBAction func cameraButtonDidPressed(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPage"), object: NewPostPageToShow.camera)
    }
    
}
