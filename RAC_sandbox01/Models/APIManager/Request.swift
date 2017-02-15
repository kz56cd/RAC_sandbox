//
//  Request.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/17.
//  Copyright © 2017年 msano. All rights reserved.
//

import Foundation
import APIKit

// http://ci.nii.ac.jp/books/opensearch/search?q={*検索ワード}
// http://ci.nii.ac.jp/books/opensearch/search?q=オブジェクト指向&count=40&format=json
// 上記の図書館蔵書検索のapiを利用する

protocol BooksRequest: Request {

}

extension BooksRequest {
    var baseURL: URL {
        return URL(string:"http://ci.nii.ac.jp/books/opensearch/search")! // json以下は後ほど
    }
}

struct GetBooksRequest: BooksRequest {
    typealias Response = Graph
    
    var method: HTTPMethod {
        return .get
    }
    var path: String {
        return ""
    }
    var parameters: Any? {
        return [
            "q": self.keyword,
            "count": "40",
            "format": "json"
        ]
    }

    private let keyword: String
    init(keyword: String) {
        self.keyword = keyword
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Graph {
        guard let dictionary = object as? [String: Any],
            let graph = dictionary["@graph"] as? [[String: Any]] else {
                throw ResponseError.unexpectedObject(object)
        }
        return Graph(object: graph[0])
    }
}
