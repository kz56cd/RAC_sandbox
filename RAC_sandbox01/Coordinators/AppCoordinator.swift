//
//  AppCoordinator.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/23.
//  Copyright © 2017年 msano. All rights reserved.
//

import UIKit

final class AppCoordinator {
    fileprivate let window: UIWindow
    fileprivate let searchCoordinator: SearchCoordinator

    init(window: UIWindow) {
        self.window = window
        self.searchCoordinator = SearchCoordinator(presenter: SearchViewController.instantiate())
    }

    func start() {
        window.rootViewController = searchCoordinator.presenter
    }
}
