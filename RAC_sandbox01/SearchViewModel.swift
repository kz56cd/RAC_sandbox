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
    var bookCellModels: [BookCellModel] { get }
    var setCellModels: MutableProperty<[BookCellModel]>? { get }
    init()
}

struct SearchViewModel: SearchViewModelType {
    
    var bookCellModels: [BookCellModel] = []
    var setCellModels: MutableProperty<[BookCellModel]>? = MutableProperty<[BookCellModel]>([])
    
    init() {
        // stub
    }
    
    mutating func sendBooksRequest(keyword: String) {
        let request = GetBooksRequest(keyword: keyword)
        var selfObj = self // TODO: 望ましくない記述
        
        print("requst keyword: \(keyword)")
        Session.send(request) { result in
            switch result {
            case .success(let list):
                for book in list {
                    selfObj.bookCellModels.append(BookCellModel(model: book))
                }
                selfObj.setCellModels?.value = selfObj.bookCellModels
            case .failure(let error):
                print("error: \(error)")
                //self.showErrorAlert() // TODO: Error表記の繋ぎ込み
            }
        }
        self = selfObj
    }
}
