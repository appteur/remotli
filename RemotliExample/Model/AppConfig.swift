//
//  AppConfig.swift
//  RemotliExample
//
//  Created by Seth on 6/4/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

// Demonstrates a simple model object for app configuration encapsulating values returned from a remote api.
class AppConfig: Codable {
    var showAds: Bool?
    var currentVersion: String?
}
