//
//  Book.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/17.
//  Copyright © 2017年 msano. All rights reserved.
//

import Foundation
import APIKit

class Book {
    var title: String     = ""
    var publisher: String = ""
    var link: String      = ""
    
    convenience init (object: [String: Any]) {
        self.init()
        let title = object["title"] as? String
        let link = object["@id"] as? String
        if let publisherArray = object["dc:publisher"] as? [String] {
            if publisherArray.count >= 1 {
                self.publisher = publisherArray[0]
            }
        }
        self.title = title ?? ""
        self.link = link ?? ""
    }
}
