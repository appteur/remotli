//
//  Token.swift
//  RemotliExample
//
//  Created by Seth on 6/4/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

/// Defines a sample token class encapsulating the json model expected to be
/// returned from a remote api.
class Token: Codable {
    var accessToken: String?
    var tokenType: String?
    var refreshToken: String?
    var expiresIn: Int?
    var scope: String?
    var accountId: String?
    var userType: String?
    var organization: String?
    var amr: [[String: String]]?
    var iss: String?
    var phoneNumber: String?
    var source: String?
    var iat: Int?
    var email: String?
    var uuid: String?
    var jti: String?
    var venueId: String?
}

extension Token {
    
    // defines coding keys for parsing from json where the json key differs
    // from the key we're using for our internal model.
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case scope
        case accountId = "account_id"
        case userType = "user_type"
        case organization
        case amr
        case iss
        case phoneNumber = "phone_number"
        case source
        case iat
        case email
        case uuid
        case jti
        case venueId
    }
}
