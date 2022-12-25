//
//  ActivityIndicator.swift
//  Giphy-Swift
//
//  Created by Hany Karam on 24/12/2022.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController : NVActivityIndicatorViewable{
    
    func showLoader() {
        DispatchQueue.main.async {
            let size = CGSize(width: 40, height: 40)
            self.startAnimating(size, message: "Loading...", type: NVActivityIndicatorType.ballBeat)
        }
    }
    func hideLoader() {
        DispatchQueue.main.async {
            self.stopAnimating()
        }
    }
}
