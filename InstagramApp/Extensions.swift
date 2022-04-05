//
//  Extensions.swift
//  InstagramApp
//
//  Created by Aviral on 05/04/22.
//  Copyright © 2022 Gwinyai Nyatsoka. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func showLoader(withView:UIView) -> UIView{
        let spinnerView = UIView.init(frame: withView.bounds)
        spinnerView.backgroundColor = .clear
        var ai:UIActivityIndicatorView!
        if #available(iOS 13.0, *) {
            ai = UIActivityIndicatorView.init(style: .medium)
        } else {
            ai = UIActivityIndicatorView.init(style: .gray)
        }
        ai.color = .red
        ai.startAnimating()
        ai.center = spinnerView.center
        spinnerView.addSubview(ai)
        withView.addSubview(spinnerView)
        return spinnerView
    }
    
    func closeLoader(spinnerView:UIView){
        spinnerView.removeFromSuperview()
    }
}
