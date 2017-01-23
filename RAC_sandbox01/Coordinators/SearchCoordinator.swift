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
        return searchViewController as SearchViewController
    }
    let searchViewController: SearchViewController
    
    init(presenter: SearchViewController) {
        searchViewController = presenter
    }
    
    func start() {
        // stub
    }
}
