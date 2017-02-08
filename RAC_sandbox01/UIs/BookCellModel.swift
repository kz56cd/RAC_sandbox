//
//  BookCellModel.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/20.
//  Copyright © 2017年 msano. All rights reserved.
//

import Foundation

protocol BookCellModelType {
    var title: String { get }
    var publisher: String? { get }
    var linkStr: String? { get }
    var bookModel: Book { get }
    init(model: Book)
}

struct BookCellModel: BookCellModelType {
    let title: String
    let publisher: String?
    let linkStr: String?
    let bookModel: Book
    init(model: Book) {
        title = model.title
        publisher = model.publisher
        linkStr = model.link
        bookModel = model
    }

    // TODO: cellの描画に関係がないので、移動させる
    // TODO: Model にもたせるか、Coordinatorで変換
    
    var link: URL {
        guard let urlStr: String = linkStr else {
            return URL(string: "")!
        }
        return URL(string: urlStr)!
    }
}
