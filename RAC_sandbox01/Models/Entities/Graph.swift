//
//  graph.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/02/10.
//  Copyright © 2017年 msano. All rights reserved.
//

import APIKit

struct Graph {
    var items: [[String: Any]]?
    var books: [Book]?
}

extension Graph {
    init(object: [String: Any]) {
        items = []
        books = []
        
        guard let items = object["items"] as? [[String: Any]] else {
            return
        }
        self.items = items
        self.books = self.items.flatMap{ $0 }?.flatMap{ Book(object: $0) }
    }
}
