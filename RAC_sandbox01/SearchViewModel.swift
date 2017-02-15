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

protocol SearchViewModelProtocol: class {
    var cellModels: Property<[BookCellModel]> { get }
    var input: MutableProperty<String> { get }
    func book(at row: Int) -> Book?
}

final class SearchViewModel: SearchViewModelProtocol {
    
    let input = MutableProperty<String>("")
    let cellModels: Property<[BookCellModel]>
    private let _cellModels = MutableProperty<[BookCellModel]>([])
    
    init() {
        cellModels = Property(_cellModels)
        input.signal
            .debounce(1.0, on: QueueScheduler.main)
            .filter { keyword -> Bool in
                return !keyword.characters.isEmpty
            }
            .observeValues { [weak self] keyword in
                // TODO:
                // RAC apiに置き換える
                self?.sendBooksRequest(keyword: keyword)
        }
    }
    
    func book(at row: Int) -> Book? {
        guard row < cellModels.value.count else {
            return nil
        }
        return cellModels.value[row].book
    }
    
    private func sendBooksRequest(keyword: String) {
        let request = GetBooksRequest(keyword: keyword)
        Session.send(request) { [weak self] result in
            switch result {
            case .success(let graph):
                self?.updateCellModels(with: graph)
            case .failure(let error):
                print("error: \(error)")
                //self.showErrorAlert() // TODO: Error表記の繋ぎ込み
            }
        }
    }
    
    private func updateCellModels(with graph: Graph) {
        _cellModels.value = graph.books.map(BookCellModel.init)
    }
}
