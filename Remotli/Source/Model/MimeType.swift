//
//  MimeType.swift
//  Remotli
//
//  Created by Seth on 6/2/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public enum MimeType: CustomStringConvertible {
    
    case textPlain
    case textHtml
    case textCss
    
    case imageJpeg
    case imagePng
    case imageGif
    case imageSvgXml
    
    case audioMpeg
    case audioOgg
    case audioWav
    case audioWebm
    case audioStar
    
    case videoMp4
    case videoWebm
    case videoOgg
    
    case applicationOgg
    case applicationStar
    case applicationJson
    case applicationFormUrlEncoded
    case applicationJavascript
    case applicationEcmascript
    case applicationOctetStream
    
    case multipartFormdata
    case multipartByteranges
    
    public var description: String {
        switch self {
            
        case .textPlain:                return "text/plain"
        case .textHtml:                 return "text/html"
        case .textCss:                  return "text/css"
            
        case .imageJpeg:                return "image/jpeg"
        case .imagePng:                 return "image/png"
        case .imageGif:                 return "image/gif"
        case .imageSvgXml:              return "image/svg+xml"
            
        case .audioMpeg:                return "audio/mpeg"
        case .audioOgg:                 return "audio/ogg"
        case .audioWav:                 return "audio/wav"
        case .audioWebm:                return "audio/webm"
        case .audioStar:                return "audio/*"
            
        case .videoMp4:                 return "video/mp4"
        case .videoWebm:                return "video/webm"
        case .videoOgg:                 return "video/ogg"
            
        case .applicationOgg:           return "application/ogg"
        case .applicationStar:          return "application/*"
        case .applicationJson:          return "application/json"
        case .applicationFormUrlEncoded:return "application/x-www-form-urlencoded"
        case .applicationJavascript:    return "application/javascript"
        case .applicationEcmascript:    return "application/ecmascript"
        case .applicationOctetStream:   return "application/octet-stream"
            
        case .multipartFormdata:        return "multipart/form-data"
        case .multipartByteranges:      return "multipart/byteranges"
        }
    }
    
    public var headerName: String {
        return "Content-Type"
    }
}
