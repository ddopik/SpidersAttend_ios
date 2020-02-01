//
//  Reachability.swift
//  SpidersAttend
//
//  Created by ddopik on 6/22/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//
import SystemConfiguration
import CFNetwork
struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}
