//
//  SearchCoordinator.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/23.
//  Copyright © 2017年 msano. All rights reserved.
//

import UIKit

final class SearchCoordinator: CoordinatorType {
    var presenter: UIViewController {
        return searchViewController as ViewController
    }
    let searchViewController: ViewController
    
    init(presenter: ViewController) {
        searchViewController = presenter
    }
    
    func start() {
        // stub
    }
}
