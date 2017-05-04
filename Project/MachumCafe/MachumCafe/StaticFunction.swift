//
//  StaticFunction.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 5. 2..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import Foundation

extension UIAlertController {
    func presentSuggestionLogInAlert(target : UIViewController, title : String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "닫기", style: .default)
        let logInAction = UIAlertAction(title: "로그인", style: .default) { _ in
            let logInStoryboard = UIStoryboard(name: "LogIn&SignUpView", bundle: nil)
            let logInViewController = logInStoryboard.instantiateViewController(withIdentifier: "LogIn")
            target.present(logInViewController, animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        alertController.addAction(logInAction)
        target.present(alertController, animated: true, completion: nil)
    }
}

extension UIActivityIndicatorView {
    func showActivityIndicatory(view: UIView) -> UIView {
        let container: UIView = UIView()
        container.frame = view.frame
        container.center = view.center
        container.backgroundColor = UIColor.gray
        container.alpha = 0.8
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = UIColor.black
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        view.addSubview(container)
        activityIndicator.startAnimating()
        return container
    }
    
    func stopActivityIndicator(view: UIView, currentIndicator : UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            currentIndicator.alpha = 0
        }) { _ in
            currentIndicator.removeFromSuperview()
        }
    }
}
