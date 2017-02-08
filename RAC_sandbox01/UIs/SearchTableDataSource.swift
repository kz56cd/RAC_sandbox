//
//  SearchTableDataSource.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/23.
//  Copyright © 2017年 msano. All rights reserved.
//

import UIKit

final class SearchTableDataSource: NSObject {
    fileprivate let bookCellModels: BookCellModels?
    
    init(cellModels: BookCellModels?) {
        if let cellModels = cellModels {
            bookCellModels = cellModels
        } else {
            bookCellModels = BookCellModels.init(model: [])
        }
        super.init()
    }
}

extension SearchTableDataSource: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let bookCellModels = bookCellModels {
            return bookCellModels.cells?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.makeCell(tableView: tableView, cellForRowAtIndexPath: indexPath)
    }
    
    // セル生成
    private func makeCell(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> BookCell {
        guard let bookCellModels = bookCellModels,
            let cells = bookCellModels.cells else {
            return UITableViewCell() as! BookCell
        }
        if (bookCellModels.cells?.count ?? 0) < indexPath.row {
            return UITableViewCell() as! BookCell
        }
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookCell else {
            return UITableViewCell() as! BookCell
        }
        cell.selectionStyle  = UITableViewCellSelectionStyle.none
        cell.configure(cellModel: cells[indexPath.row])
        return cell
    }
}
