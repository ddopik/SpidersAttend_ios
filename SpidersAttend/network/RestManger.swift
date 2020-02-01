//
//  RestManger.swift
//  SpidersAttend
//
//  Created by ddopik on 6/19/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//
import Alamofire

class RestManger {
    
    var requestHttpHeaders = RestEntity()
    
    var urlQueryParameters = RestEntity()
    
    var httpBodyParameters = RestEntity()
    
    
    
}
extension RestManger{
    
    struct RestEntity {
        private var values: [String: String] = [:]
        
        mutating func add(value: String, forKey key: String) {
            values[key] = value
        }
        
        func value(forKey key: String) -> String? {
            return values[key]
        }
        
        func allValues() -> [String: String] {
            return values
        }
        
        func totalItems() -> Int {
            return values.count
        }
    }
    
    
    struct Response {
        var response: URLResponse?
        var httpStatusCode: Int = 0
        var headers = RestEntity()
    }
    
    
    
    enum HttpMethod: String {
        case get
        case post
        case put
        case patch
        case delete
    }

    
}
