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
//    var datasource: SearchTableDataSource? { get }
    var datasource: MutableProperty<SearchTableDataSource>? { get }
//    var _datasource: SearchTableDataSource? { get }
    
    init(keyword: String)
}

struct SearchViewModel: SearchViewModelType {

    var bookCellModels: BookCellModels?
//    var datasource: SearchTableDataSource?
    var datasource: MutableProperty<SearchTableDataSource>?
    
    init(keyword: String) {
        sendBooksRequest(keyword: keyword)
    }
    
    private mutating func sendBooksRequest(keyword: String) {
        //HUD.flash(.progress, delay: 0.2)
        
        let request = GetBooksRequest(keyword: keyword)
        var selfObj = self // TODO 望ましくない記述
        
        print("requst keyword: \(keyword)")
        Session.send(request) { result in
            switch result {
            case .success(let books):
                selfObj.bookCellModels = BookCellModels.init(model: books.list)
                selfObj.datasource = MutableProperty<SearchTableDataSource>(SearchTableDataSource(cellModels: selfObj.bookCellModels!))
//                selfObj.datasource = MutableProperty<SearchTableDataSource>(nil)
                selfObj.datasource?.value = SearchTableDataSource(cellModels: selfObj.bookCellModels!)
                print(books)
            case .failure(let error):
                print("error: \(error)")
                //self.showErrorAlert()
            }
        }
        self = selfObj
    }
}
