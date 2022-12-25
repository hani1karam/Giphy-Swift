//
//  className.swift
//  Giphy-Swift
//
//  Created by Hany Karam on 24/12/2022.
//

import Foundation
extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }

    @objc class func swiftClassFromString(className: String) -> AnyClass! {
        if let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String? {
            let fAppName = appName.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
            return NSClassFromString("\(fAppName).\(className)")
        }
        return nil
    }
}
