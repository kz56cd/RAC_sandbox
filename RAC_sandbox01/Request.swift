//
//  Request.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/17.
//  Copyright © 2017年 msano. All rights reserved.
//

import Foundation
import APIKit

// TODO:
// http://ci.nii.ac.jp/books/opensearch/search?q={*検索ワード}
// 上記の図書館蔵書検索のapiを利用する

protocol BooksRequestType: Request {
    
}

extension BooksRequestType {
    var baseURL:URL {
        return URL(string:"http://ci.nii.ac.jp/books/opensearch/search")! as URL // json以下は後ほど
    }
}

struct GetBooksRequest: BooksRequestType {
    typealias Response = Books
    
    var method: HTTPMethod {
        return .get
    }
    var path: String {
        return ""
    }
    var parameters: Any? {
        return [
            "q": "オブジェクト指向",
            "count": "3",
            "format": "json"
        ]
    }
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Books {
        return try Books(object: object)
    }
}
