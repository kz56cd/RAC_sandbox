//
//  graph.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/02/10.
//  Copyright © 2017年 msano. All rights reserved.
//

import APIKit

struct Graph {
    let books: [Book]
}

extension Graph {
    init?(object: [String: Any]) {
        guard let books = (object["items"] as? [[String: Any]])?.flatMap(Book.init),
            !books.isEmpty else {
                return nil
        }
        self.books = books
    }
}
