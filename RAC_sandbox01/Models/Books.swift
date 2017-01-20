//
//  Books.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/16.
//  Copyright © 2017年 msano. All rights reserved.
//

import Foundation
import APIKit

struct Books {
    var list: [Book] = []
}

extension Books {
    init (object: Any) throws {
        
        // try parse
        
        guard let dictionary = object as? [String: Any],
            let graph = dictionary["@graph"] as? Array<Any> else {
                throw ResponseError.unexpectedObject(object)
        }
        for data in graph {
            guard let datadic = data as? [String: Any],
                let items = datadic["items"] as? Array<Any> else {
                    throw ResponseError.unexpectedObject(object)
            }
            for item in items {
                guard let item = item as? [String: Any],
                    let book:Book = Book(object: item) else {
                        throw ResponseError.unexpectedObject(object)
                }
                list.append(book)
            }
        }
    }
}
