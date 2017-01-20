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
//            guard let cell: BookCellModel = BookCellModel.init(model: book) else {
            guard let cell = BookCellModel.init(model: book) as? BookCellModel else {
                return
            }
            self.cells?.append(cell)
        }
    }
}
