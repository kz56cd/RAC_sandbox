//
//  Book.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/17.
//  Copyright © 2017年 msano. All rights reserved.
//

import Foundation
import APIKit

struct Book {
    let title: String
    let publisher: String?
    let link: String?
}

extension Book {
    init?(object: [String: Any]) {
        guard let title = object["title"] as? String else {
            return nil
        }
        self.publisher = (object["dc:publisher"] as? [String])?.first ?? nil
        self.title = title
        self.link = object["@id"] as? String
    }
}
