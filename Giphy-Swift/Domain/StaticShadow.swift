//
//  StaticShadow.swift
//  Giphy-Swift
//
//  Created by Hany Karam on 24/12/2022.
//

import UIKit
extension UIView{
    func staticShadow(withOffset value:CGSize,color: CGColor){
        self.layer.shadowColor = color
        self.layer.shadowOpacity = 3
        self.layer.shadowOffset = value
        self.layer.shadowRadius = 4
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
}
