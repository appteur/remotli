//
//  FormDataPlugin.swift
//  Remotli
//
//  Created by Seth on 6/1/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public class FormDataPlugin: RequestPlugin {
    
    public var identifier = RequestPluginIdentifier.formData.description
    
    let boundary = "----------.77659.remotli.boundary.77659.----------"
    var fileType: String = ""
    var contentType: String?
    
    public init() {
        // here for conformance with convention
    }

    public func configure(_ request: inout URLRequest, for routable: Routable) {
        
        guard routable.method == .put || routable.method == .post,
            routable.mimeType == .multipartFormdata,
            let body = formData(for: routable) else {
            return
        }
        
        request.httpBody = body
        request.addValue("\(body.count)", forHTTPHeaderField: "Content-Length")
        
        if let contentType = contentType {
            request.addValue(contentType, forHTTPHeaderField: routable.mimeType.headerName)
        }
    }
    
    func formData(for routable: Routable) -> Data? {
        
        guard let params = routable.parameters else {
            return nil
        }
        
        // setup content type header info
        contentType = "\(routable.mimeType.description); boundary=\(boundary)"
        
        // this will be our body data
        var body : Data = Data()
        var files: [String : Data] = [:]
        
        // add parameters to body, pull files out and put into files array to process last
        for (key,value) in params {
            if let value = value as? Data {
                files[key] = value
            } else if let value = value as? String {
                addParameter(value, named: key, to: &body)
            }
        }
        
        // add files to end of body
        for (key,value) in files {
            addFile(value, named: key, to: &body)
        }
        
        // close the body data
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
    
    internal func addParameter(_ value: String, named: String, to body: inout Data) {
        
        guard let boundaryData = "--\(boundary)\r\n".data(using: .utf8),
              let nameData = "Content-Disposition: form-data; name=\"\(named)\"\r\n\r\n".data(using: .utf8),
              let valueData = "\(value)\r\n".data(using: .utf8) else {
                return
        }
        
        body.append(boundaryData)
        body.append(nameData)
        body.append(valueData)
    }
    
    internal func addFile(_ data: Data, named: String, to body: inout Data) {
        
        guard let bound = "--\(boundary)\r\n".data(using: .utf8),
            let name = "Content-Disposition: form-data; name=\"\(named)\"; filename=\"\(named)\"\r\n".data(using: .utf8),
            let type = "Content-Type: \(fileType)\r\n\r\n".data(using: .utf8),
            let end = "\r\n".data(using: .utf8) else {
                return
        }
        
        body.append(bound)
        body.append(name)
        body.append(type)
        body.append(data)
        body.append(end)
    }
}
