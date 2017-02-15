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
    
    let method: HTTPMethod = .get
    let path: String = ""
    let parameters: Any?
    
    init(keyword: String) {
        parameters = [
            "q": keyword,
            "count": "40",
            "format": "json"
        ]
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Graph {
        guard let dictionary = object as? [String: Any],
            let graphDictionary = dictionary["@graph"] as? [[String: Any]],
            let firstGraphDictionary = graphDictionary.first,
            let graph = Graph(object: firstGraphDictionary) else {
                throw ResponseError.unexpectedObject(object)
        }
        return graph
    }
}
