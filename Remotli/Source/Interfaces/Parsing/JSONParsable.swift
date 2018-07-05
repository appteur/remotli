//
//  JSONParsable.swift
//  Remotli
//
//  Created by Seth on 6/1/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

protocol JSONParsable: Parsable {
    var decoder: JSONDecoder { get }
}

extension JSONParsable {
    
    internal func parseData<T: Codable>(from data: Data) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.dataCorrupted(let error) {
            print("Remotli: JSONResponseParserPlugin - Error - Data corrupted \(error)")
            throw SerializationError.parseError
        } catch DecodingError.keyNotFound(let key, _) {
            print("Remotli: JSONResponseParserPlugin - Error - Key not found \(key.stringValue)")
            throw SerializationError.parseError
        } catch DecodingError.typeMismatch(let type, _){
            print("Remotli: JSONResponseParserPlugin - Error - type mismatch \(type)")
            throw SerializationError.parseError
        } catch {
            print("Remotli: JSONResponseParserPlugin - Error - \(error.localizedDescription)")
            throw SerializationError.parseError
        }
    }
}
