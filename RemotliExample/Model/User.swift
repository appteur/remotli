//
//  User.swift
//  RemotliExample
//
//  Created by Seth on 6/4/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

/// Defines a sample user model encapsulating values expected to be returned from the remote api.
public class User: Codable {
    public var identifier: String
    public var firstName: String
    public var lastName: String
    public var email: String
    public var phone: String?
    public var birthday: String?
    public var isPendingVerification: Bool = false
    
    public init(identifier: String, firstName: String, lastName: String, email: String, phone: String?, birthday: String?, isPendingVerification: Bool = false) {
        self.identifier = identifier
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.birthday = birthday
        self.isPendingVerification = isPendingVerification
    }
}
