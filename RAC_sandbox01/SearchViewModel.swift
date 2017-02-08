//
//  SearchViewModel.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/31.
//  Copyright © 2017年 msano. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import APIKit

protocol SearchViewModelType {
    var bookCellModels: BookCellModels? { get }
    var datasource: MutableProperty<SearchTableDataSource>? { get }
    init()
}

struct SearchViewModel: SearchViewModelType {
    
    var bookCellModels: BookCellModels? = BookCellModels.init(model: [])
    var datasource: MutableProperty<SearchTableDataSource>? = MutableProperty<SearchTableDataSource>(SearchTableDataSource(cellModels: BookCellModels.init(model: []))) // TODO: 長い
    
    init() {
        // stub
    }
    
    mutating func sendBooksRequest(keyword: String) {
        let request = GetBooksRequest(keyword: keyword)
        var selfObj = self // TODO 望ましくない記述
        
        print("requst keyword: \(keyword)")
        Session.send(request) { result in
            switch result {
            case .success(let books):
                selfObj.bookCellModels = BookCellModels.init(model: books.list)
                selfObj.datasource?.value = SearchTableDataSource(cellModels: selfObj.bookCellModels!)
                print(books)
            case .failure(let error):
                print("error: \(error)")
                //self.showErrorAlert() // TODO: Error表記の繋ぎ込み
            }
        }
        self = selfObj
    }
}
