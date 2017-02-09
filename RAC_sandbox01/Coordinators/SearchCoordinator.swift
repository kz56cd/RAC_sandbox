//
//  SearchCoordinator.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/23.
//  Copyright © 2017年 msano. All rights reserved.
//

import UIKit
import SafariServices

final class SearchCoordinator: CoordinatorType {
    var presenter: UIViewController {
        return searchViewController as SearchViewController
    }
    let searchViewController: SearchViewController

    init(presenter: SearchViewController) {
        searchViewController = presenter
        searchViewController.searchCoordinator = self
    }

    func start() {
        // stub
    }

    func presentBookDetail(with book: Book) {
        guard let link = book.link,
            let linkUrl: URL = URL(string: link) else {
            return
        }
        let safariVC = SFSafariViewController(url: linkUrl)
        searchViewController.present(safariVC, animated: true, completion: nil)
    }
}
