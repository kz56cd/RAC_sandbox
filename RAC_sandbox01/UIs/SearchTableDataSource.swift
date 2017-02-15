//
//  SearchTableDataSource.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/23.
//  Copyright © 2017年 msano. All rights reserved.
//

import UIKit

final class SearchTableDataSource: NSObject {
    fileprivate var bookCellModels: [BookCellModel]?
    
    func updateCellModels(to cellModels: [BookCellModel]) {
        bookCellModels = cellModels
    }
}

extension SearchTableDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let bookCellModels = bookCellModels {
            return bookCellModels.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.makeCell(tableView: tableView, cellForRowAtIndexPath: indexPath)
    }

    // セル生成
    private func makeCell(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        if let cell = cell as? BookCell {
            guard let bookCellModels = bookCellModels,
                indexPath.row < bookCellModels.count else {
                    return cell
            }
            cell.configure(with: bookCellModels[indexPath.row])
        }
        cell.selectionStyle  = UITableViewCellSelectionStyle.none
        return cell
    }
}
