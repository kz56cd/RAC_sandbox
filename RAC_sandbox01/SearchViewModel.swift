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
//    var datasource: MutableProperty<SearchTableDataSource>? { get }
//    var _datasource: SearchTableDataSource? { get }
    var datasource: Action<SearchTableDataSource, SearchTableDataSource, NoError>? { get }

    init(keyword: String)
}

struct SearchViewModel: SearchViewModelType {

    var bookCellModels: BookCellModels?
//    var datasource: SearchTableDataSource?
//    var datasource: MutableProperty<SearchTableDataSource>?
    var datasource: Action<SearchTableDataSource, SearchTableDataSource, NoError>?
    
    init(keyword: String) {

        var selfObj = self // TODO 望ましくない記述
        datasource = Action<SearchTableDataSource, SearchTableDataSource, NoError> { (searchTableDataSource: SearchTableDataSource) -> SignalProducer<SearchTableDataSource, NoError> in
            return SignalProducer<SearchTableDataSource, NoError> { (observer, disposable) in
                print("t 003")
                observer.send(value: searchTableDataSource)
                print("t 004")
                observer.sendCompleted()
            }
        }
        print("t 001")
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
                print("t 002")
                selfObj.bookCellModels = BookCellModels.init(model: books.list)
                
                let ds = SearchTableDataSource(cellModels: selfObj.bookCellModels!)
                selfObj.datasource?.apply(ds).start()
//                selfObj.datasource?.apply(ds).startWithResult({ result in
//                    switch result {
//                    case let .success(value):
//                        print(value)
//                    case let .failure(error):
//                        print(error)
//                    }
//                })
//                selfObj.datasource?.start()
                print(books)
            case .failure(let error):
                print("error: \(error)")
                //self.showErrorAlert()
            }
        }
        self = selfObj
    }
}
