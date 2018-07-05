//
//  Parsable.swift
//  Remotli
//
//  Created by Seth on 6/1/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

protocol Parsable {
    func parseData<T: Codable>(from data: Data) throws -> T
}
