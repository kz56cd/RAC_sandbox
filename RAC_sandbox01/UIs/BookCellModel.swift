//
//  BookCellModel.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/20.
//  Copyright © 2017年 msano. All rights reserved.
//

import Foundation

protocol BookCellModelType {
    var title: String? { get }
    var publisher: String? { get }
    var link: String? { get }
    var bookModel: Book? { get }
    init(model: Book)
}

struct BookCellModel: BookCellModelType {
    let title: String?
    let publisher: String?
    let link: String?
    let bookModel: Book?
    init(model: Book) {
        title = model.title
        publisher = model.publisher
        link = model.link
        bookModel = model
    }
}
