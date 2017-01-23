//
//  CoordinatorType.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/23.
//  Copyright © 2017年 msano. All rights reserved.
//

import UIKit

protocol CoordinatorType {
    var presenter: UIViewController { get }
    func start()
}
