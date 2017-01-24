//
//  BooksCellModels.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/20.
//  Copyright © 2017年 msano. All rights reserved.
//

import Foundation

protocol BookCellModelsType {
    var cells: [BookCellModel]? { get }
    init(model: [Book])
}

struct BookCellModels: BookCellModelsType {
    let cells: [BookCellModel]?
    init(model: [Book]) {
        cells = []
        for book: Book in model {
            self.cells?.append(BookCellModel.init(model: book))
        }
    }
}
