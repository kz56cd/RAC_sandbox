//
//  RequestStub.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/20.
//  Copyright © 2017年 msano. All rights reserved.
//

import Foundation
import OHHTTPStubs

//struct RequestStub {
//    
//    static func getBooksWithSearch(bookRequest: BooksRequestType) -> Books {
//        guard let stubPath = OHPathForFile("stub_search_book.json", type(of: self) as! AnyClass) else {
//            return Books(object: nil)
//        }
//        let object = fixture(filePath: stubPath, headers: nil)
//        return Books(object: object)
//    }
//}

//struct RequestStub {
//    
//    static func getBooksWithSearch(bookRequest: BooksRequestType) -> [String: Any] {
//        return [
//            "id": 1,
//            "company": TagmatchAPIStub.makeCompany(userFollowed: true, companyFollowed: false),
//            "datetime": "2016-09-02T00:00:00+00:00",
//            "from": sender.rawValue,
//            "action": action.rawValue
//        ]
//    }
//}
