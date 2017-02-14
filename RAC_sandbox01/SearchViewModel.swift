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

protocol SearchViewModelProtocol {
    var bookCellModels: [BookCellModel] { get }
    var input: MutableProperty<String> { get }
    var setCellModels: MutableProperty<[BookCellModel]>? { get }
    init()
}

struct SearchViewModel: SearchViewModelProtocol {

    var bookCellModels: [BookCellModel] = []
    let input: MutableProperty<String> = MutableProperty<String>("")
    let setCellModels: MutableProperty<[BookCellModel]>? = MutableProperty<[BookCellModel]>([])

    init() {
        var selfObj = self // TODO: 望ましくない記述
        input.signal
            .debounce(1.0, on: QueueScheduler.main)
            .observeValues { keyword in
                // TODO:
                // RAC apiに置き換える
                if keyword.characters.count >= 1 {
                    selfObj.sendBooksRequest(keyword: keyword)
                }
        }
    }
    
    func getBook(with row: Int) -> Book? {
        return bookCellModels[row].book
    }
    
    mutating func sendBooksRequest(keyword: String) {
        let request = GetBooksRequest(keyword: keyword)
        var selfObj = self // TODO: 望ましくない記述

        print("requst keyword: \(keyword)")
        Session.send(request) { result in
            switch result {
            case .success(let graph):
                selfObj.configureCellModels(with: graph)
            case .failure(let error):
                print("error: \(error)")
                //self.showErrorAlert() // TODO: Error表記の繋ぎ込み
            }
        }
        self = selfObj
    }

    private mutating func configureCellModels(with graph :Graph) {
        guard let books: [Book] = graph.books else {
            setCellModels?.value = []
            return
        }
        for book in books {
            bookCellModels.append(BookCellModel(model: book))
        }
        setCellModels?.value = bookCellModels
    }
}
