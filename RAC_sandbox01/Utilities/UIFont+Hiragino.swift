//
//  UIFont+Hiragino.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/26.
//  Copyright © 2017年 msano. All rights reserved.
//

import UIKit

extension UIFont {
    enum HiraginoTypeface: String {
        case W3//swiftlint:disable:this type_name
        case W6//swiftlint:disable:this type_name
    }
    class func hiraKakuProN(_ typeface: HiraginoTypeface, size: CGFloat) -> UIFont {
        return UIFont(name: "HiraKakuProN-"+typeface.rawValue, size: size)!
    }
}
