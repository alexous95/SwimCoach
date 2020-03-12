//
//  UIImageExtension.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 26/02/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit
import Foundation

extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 2, height: 2)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 2, height: 2), false, 0)
        color.setFill()
        UIRectFill(rect)
        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return image
    }
}
