//
//  SearchViewModel.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/31.
//  Copyright © 2017年 msano. All rights reserved.
//

import UIKit


protocol SearchViewModelType {
    var bookCellModels: BookCellModels? { get }
    var datasource: SearchTableDataSource? { get }
    init(books: Books)
}

struct SearchViewModel: SearchViewModelType {

    var bookCellModels: BookCellModels?
    var datasource: SearchTableDataSource?
    
    init(books: Books) {
        self.bookCellModels = BookCellModels.init(model: books.list)
        self.datasource = SearchTableDataSource(cellModels: self.bookCellModels!)
    }
}
