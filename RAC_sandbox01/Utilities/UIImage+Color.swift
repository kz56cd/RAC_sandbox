//
//  UIImage+Color.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/26.
//  Copyright © 2017年 msano. All rights reserved.
//

import UIKit

extension UIImage {
    class func makeImage(with color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        context.setFillColor(color.cgColor)
        context.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}
