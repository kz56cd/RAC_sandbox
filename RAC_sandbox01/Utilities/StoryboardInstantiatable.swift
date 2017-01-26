//
//  StoryboardInstantiatable.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/17.
//  Copyright © 2017年 msano. All rights reserved.
//

import UIKit

protocol StoryboardInstantiatable {}

extension StoryboardInstantiatable {
    static func instantiate() -> Self {
        let storyBoard = UIStoryboard(name: String(describing: Self.self), bundle: nil)
        return storyBoard.instantiateInitialViewController() as! Self // swiftlint:disable:this force_cast
    }
}
