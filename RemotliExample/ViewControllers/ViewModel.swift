//
//  ViewModel.swift
//  RemotliExample
//
//  Created by Seth on 6/4/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation
import Remotli

class ViewModel {
    
    internal var demo1: Demo1Client
    internal var demo2: Demo2Client
    
    init() {
        demo1 = Demo1Client(configuration: RemoteSites.demo1())
        demo2 = Demo2Client(configuration: RemoteSites.demo2())
    }
    
    func fetchToken(completion: @escaping (Token?, Error?) -> Void) {
        demo2.getToken(completion: completion)
    }
    
    func fetchConfig(completion: @escaping (AppConfig?, Error?) -> Void) {
        demo1.getConfig2(completion: completion)
    }
    
    func login(email: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        demo2.login(username: email, password: password, completion: completion) 
    }
}
