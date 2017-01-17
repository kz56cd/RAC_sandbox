//
//  Books.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/16.
//  Copyright © 2017年 msano. All rights reserved.
//

import Foundation
import APIKit

//// TODO:
//// http://ci.nii.ac.jp/books/opensearch/search?q={*検索ワード}
//// 上記の図書館蔵書検索のapiを利用する
//
//// ====== DataModel ======
//
//struct BooksData {
//    var title: String     = ""
//    var publisher: String = ""
//    var link: String      = ""
//    
//    init (object: Any) throws {
//        
//        // try parse
//        
//        guard let dictionary = object as? [String: Any],
//            let graph = dictionary["@graph"] as? Array<Any> else {
//                throw ResponseError.unexpectedObject(object)
//        }
//        // print("graph.count: \(graph.count)")
//        for data in graph {
//            guard let datadic = data as? [String: Any],
//                  let items = datadic["items"] as? Array<Any> else {
//                throw ResponseError.unexpectedObject(object)
//            }
//            for item in items {
//                guard let item = item as? [String: Any] else {
//                    throw ResponseError.unexpectedObject(object)
//                }
//                let book:Book = Book(object: item)
//                print("title: \(book.title)")
//                print("link: \(book.link)")
//                
//            }
//        }
//    }
//}
//
//// ====== Defining request type ======
//
//
//protocol BooksRequestType: Request {
//    
//}
//
//extension BooksRequestType {
//    var baseURL:URL {
//        return URL(string:"http://ci.nii.ac.jp/books/opensearch/search")! as URL // json以下は後ほど
//    }
//}
//
//struct GetBooksRequest: BooksRequestType {
//    typealias Response = BooksData
//    
//    var method: HTTPMethod {
//        return .get
//    }
//    var path: String {
//        return ""
//    }
//    var parameters: Any? {
//        return [
//            "q": "オブジェクト指向",
//            "count": "3",
//            "format": "json"
//        ]
//    }
//    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> BooksData {
//        return try BooksData(object: object)
//    }
//}

