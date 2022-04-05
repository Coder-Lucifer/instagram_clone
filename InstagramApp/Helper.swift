//
//  Helper.swift
//  InstagramApp
//
//  Created by Aviral on 05/04/22.
//  Copyright © 2022 Gwinyai Nyatsoka. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase


class Helper {
    class func errorAlert(title:String,message:String) -> UIAlertController {
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default) { action in
            errorAlert.dismiss(animated: true)
        }
        errorAlert.addAction(okAction)
        return errorAlert
    }
}

class LoginAuth {
    class func firebaseLogin(email:String,password:String,userName:String="",fromSignUp:Bool=false,self:UIViewController){
        let spinnerView = self.showLoader(withView: self.view)
        Auth.auth().signIn(withEmail: email, password: password) {  resultData, error in
            DispatchQueue.main.async {
                self.closeLoader(spinnerView: spinnerView)
            }
            if error == nil {
                if fromSignUp {
                    guard let userId = resultData?.user.uid else {
                        return
                    }
                    let userRef = Database.database().reference().child("users").child(userId)
                    userRef.updateChildValues(["userName":userName,"bio":"love to code"])
                    DispatchQueue.main.async {
                        CustomRootView.goToHomePage(window: nil)
                    }
                }else{
                    DispatchQueue.main.async {
                        CustomRootView.goToHomePage(window: nil)
                    }
                }
            }else if let error = error{
                authErrorHandler(error: error, fromSignUp: fromSignUp,self: self)
            }
        }
    }
    
    
    class func authErrorHandler(error:Error,fromSignUp:Bool,self:UIViewController){
        var title = "Login Error"
        var message = "There was a problem loggin in"
        if fromSignUp {
            title = "SignUp Error"
            message = "There was a problem while signing up"
        }
        let errorCode = AuthErrorCode(rawValue: error._code)
        switch errorCode {
        case .invalidEmail:
            title = "Invalid Email"
            message = "Please enter a valid email"
            break
        case .wrongPassword:
            title = "Invalid Password"
            message = "Please enter a valid password"
            break
        case .emailAlreadyInUse:
            title = "Email Exist"
            message = "A user already exists with the same email"
        case .weakPassword:
            title = "Weak Password"
            message = "Please use a much stronger password"
        case .missingEmail:
            title = "Missing Email"
            message = "The email you are trying to access is not registered"
        default:
            break
        }
        let alert = Helper.errorAlert(title: title, message: message)
        self.present(alert, animated: true)
    }
    
    class func firebaseSignUp(email:String,password:String,userName:String,self:UIViewController){
        let spinnerView = self.showLoader(withView: self.view)
        Auth.auth().createUser(withEmail: email, password: password) { resultData, error in
            DispatchQueue.main.async {
                self.closeLoader(spinnerView: spinnerView)
            }
            if error == nil {
                DispatchQueue.main.async {
                    self.closeLoader(spinnerView: spinnerView)
                }
                firebaseLogin(email: email, password: password, userName: userName, fromSignUp:true, self: self)
            }else if let error = error{
                authErrorHandler(error: error, fromSignUp: true,self: self)
            }
        }
    }
    
    class func logoutFirebase(self:UIViewController){
        do {
            let spinnerView = self.showLoader(withView: self.view)
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.closeLoader(spinnerView: spinnerView)
            }
            let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil)
            let loginViewController = loginStoryBoard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            guard let window = appDelegate.window else {return}
            window.rootViewController = loginViewController
        }catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}


class CustomRootView {
    
    class func checkAuthAndMakeDecision(window:UIWindow?){
        if let user = Auth.auth().currentUser {
            print("Got User:::::: \(user)")
            goToHomePage(window: window)
        }else{
            print("No User Logged In")
            goToLogin(window: window!)
        }
    }
    
    class func goToHomePage(window:UIWindow?){
        let tabBarController = UITabBarController()

        let homeStoryBoard = UIStoryboard(name: "Home", bundle: nil)
        let searchStoryBoard = UIStoryboard(name: "Search", bundle: nil)
        let newPostStoryBoard = UIStoryboard(name: "NewPost", bundle: nil)
        let profileStoryBoard = UIStoryboard(name: "Profile", bundle: nil)
        let activityStoryBoard = UIStoryboard(name: "Activity", bundle: nil)
        
        let homeVC = homeStoryBoard.instantiateViewController(withIdentifier: "Home") as! HomeViewController
        let searchVC = searchStoryBoard.instantiateViewController(withIdentifier: "Search") as! SearchViewController
        let newPostVC = newPostStoryBoard.instantiateViewController(withIdentifier: "NewPost") as! NewPostViewController
        let profileVC = profileStoryBoard.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
        let activityVC = activityStoryBoard.instantiateViewController(withIdentifier: "Activity") as! ActivityViewController
        
        let vcData : [(UIViewController,UIImage,UIImage)] = [
            (homeVC,UIImage(named: "home_tab_icon")!,UIImage(named: "home_selected_tab_icon")!),
            (searchVC,UIImage(named: "search_tab_icon")!,UIImage(named: "search_selected_tab_icon")!),
            (newPostVC,UIImage(named: "post_tab_icon")!,UIImage(named: "post_tab_icon")!),
            (activityVC,UIImage(named: "activity_tab_icon")!,UIImage(named: "activity_selected_tab_icon")!),
            (profileVC,UIImage(named: "profile_tab_icon")!,UIImage(named: "profile_selected_tab_icon")!),
        ]
        
        let vcs = vcData.map { (vc, defaultImage, selectedImage) -> UINavigationController in
            let navigation = UINavigationController(rootViewController: vc)
            navigation.tabBarItem.image = defaultImage
            navigation.tabBarItem.selectedImage = selectedImage
            return navigation
        }
        
        tabBarController.viewControllers = vcs
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = UIColor.white
        tabBarController.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBarController.tabBar.layer.shadowRadius = 2
        tabBarController.tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBarController.tabBar.layer.shadowOpacity = 0.3
        tabBarController.delegate = tabBarDelegate
        
        
        if let items = tabBarController.tabBar.items {

            for item in items {
                if let image = item.image {
                    item.image = image.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
                }
                if let selectedImage = item.selectedImage {
                    item.selectedImage = selectedImage.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
                }

                item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            }
        }

        UINavigationBar.appearance().backgroundColor = UIColor.white
        if(window != nil){
            window?.rootViewController = tabBarController
        }else{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            guard let window = appDelegate.window else {return}
            window.rootViewController = tabBarController
        }
    }
    
    class func goToLogin(window:UIWindow!){
        let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewController = loginStoryBoard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        window.rootViewController = loginViewController
    }
    

    
}
