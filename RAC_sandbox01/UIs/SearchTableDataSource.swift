//
//  SearchTableDataSource.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/23.
//  Copyright © 2017年 msano. All rights reserved.
//

import UIKit

final class SearchTableDataSource: NSObject {
    fileprivate var bookCellModels: [BookCellModel]? = nil // TODO: ここはvarにすべき
    
//    init(cellModels: [BookCellModel]?) {
//        bookCellModels = cellModels
//        super.init()
//    }
    
}

extension SearchTableDataSource: UITableViewDataSource {
    
    func set(with cellModels: [BookCellModel]?) {
        bookCellModels = cellModels
    }
    
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
    private func makeCell(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> BookCell {
        // TODO: 整理する
        // TODO: BookCellModels は廃止して、[BookCellModel]に変える
        guard let bookCellModels = bookCellModels else {
            return UITableViewCell() as! BookCell
        }
        if (bookCellModels.count) < indexPath.row {
            return UITableViewCell() as! BookCell
        }
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookCell else {
            return UITableViewCell() as! BookCell
        }
        cell.selectionStyle  = UITableViewCellSelectionStyle.none
        cell.configure(with: bookCellModels[indexPath.row])
        return cell
    }
}
