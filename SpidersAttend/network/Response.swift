//
//  File.swift
//  SpidersAttend
//
//  Created by ddopik on 6/19/19.
//  Copyright © 2019 Brandeda. All rights reserved.
struct Response {
    var response: URLResponse?
    var httpStatusCode: Int = 0
    var headers = RestEntity()
    
    
    init(fromURLResponse response: URLResponse?) {
        guard let response = response else { return }
        self.response = response
        httpStatusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        
        if let headerFields = (response as? HTTPURLResponse)?.allHeaderFields {
            for (key, value) in headerFields {
                headers.add(value: "\(value)", forKey: "\(key)")
            }
        }
    }
    
    
    
    init(fromURLResponse response: URLResponse?) {
        guard let response = response else { return }
        self.response = response
        httpStatusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        
        if let headerFields = (response as? HTTPURLResponse)?.allHeaderFields {
            for (key, value) in headerFields {
                headers.add(value: "\(value)", forKey: "\(key)")
            }
        }
    }
    
}
