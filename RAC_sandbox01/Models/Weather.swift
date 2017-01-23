//
//  Weather.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/16.
//  Copyright © 2017年 msano. All rights reserved.
//

import Foundation
import APIKit


// ====== DataModel ======


struct WeatherData {
    var title: String = ""
    var descripton: String = ""
    var today: String = ""
    var tomorrow: String = ""
    
    init (object: Any) throws {
        // try parse
        guard let dictionary = object as? [String: Any],
            let title = dictionary["title"] as? String,
            let descriptonDic = dictionary["description"] as? [String: Any],
            let descripton = descriptonDic["text"] as? String else {
                throw ResponseError.unexpectedObject(object)
        }
        self.title = title
        self.descripton = descripton
    }
}


// ====== Defining request type ======


protocol WeatherRequestType: Request {
    
}

extension WeatherRequestType {
    var baseURL:URL {
        return URL(string:"http://weather.livedoor.com/forecast/webservice/json")! as URL // json以下は後ほど
    }
}

struct GetWeatherRequest: WeatherRequestType {
    typealias Response = WeatherData
    
//    var baseURL: URL {
//    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/v1"
    }
    
    var parameters: Any? {
        return ["city": "016010",]
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> WeatherData {
    return try WeatherData(object: object)
    }
}
