//
//  BooksCellModels.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/20.
//  Copyright © 2017年 msano. All rights reserved.
//

import Foundation
import Result
import ReactiveSwift

protocol BookCellModelsType {
    var keyword: MutableProperty<String> { get }
    var validation: MutableProperty<Bool>? { get }
    var cells: [BookCellModel]? { get }
    init(model: [Book])
}

struct BookCellModels: BookCellModelsType {

    let keyword: MutableProperty<String> = MutableProperty("")
    internal var validation: MutableProperty<Bool>?
    
    let cells: [BookCellModel]?
    init(model: [Book]) {
        cells = []
        for book: Book in model {
            self.cells?.append(BookCellModel.init(model: book))
        }
    }
}

struct BookError: Error {
    
}
