//
//  Remotely.swift
//  Remotli
//
//  Created by Seth on 5/25/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public protocol Remotely: class {
    
    /// A configuration object specifying the remote host details to use for connecting.
    var config: HostConfiguration { get }
    
    /// A reachability instance for determining connectivity to the specified remote host.
    var reachability: NetworkAccessibilityProvider? { get set }
    
    /// A network URLSession to use for processing and handling requests to the remote host.
    var session: URLSession { get }
    
    /// A plugin or aggregate plugin to be used for modifying or configuring outgoing requests.
    var requestPlugin: RequestPlugin? { get set }
    
    /// A plugin or aggregate plugin to be used for modifying or configuring incoming responses.
    var responsePlugin: ResponsePlugin? { get set }
    
    func send<T: Codable>(requestFor routable: Routable, completion: @escaping (T?, Error?) -> Void)
}

extension Remotely {
    
    /// A convenience function for quickly sending requests to your remote host.
    ///
    /// - Parameters:
    ///   - path: The relative path on the remote host.
    ///   - port: The port number or nil.
    ///   - method: The HTTPMethod to use for sending this request.
    ///   - mimeType: The mime type for the data being sent.
    ///   - headers: Any headers to send with this request.
    ///   - parameters: Any parameters to send with this request. All parameters for any http method should be passed in this dictionary. They will be added to the request as post body parameters or get url parameters using the specified mime type when the url request is generated.
    ///   - usingAuth: If auth is required set this to 'true'. The authorization header will be set for requests requiring authentication.
    ///   - completion: The completion handler to run when the request is complete. The first parameter will be an object conforming to the Codable protocol so the parser will know which type to create when parsing the json response. The second parameter will be an Error type. If an error is returned the first parameter will be nil, the error will be an aggregate error type with the error status set and the parsed json error if one was returned from the api.
    public func send<T: Codable>(_ path: String, port: Int? = nil, method: HTTPMethod = .post, mimeType: MimeType = .applicationJson, headers: [String: String]? = nil, parameters: [String: Any]? = nil, usingAuth: Bool = false, completion: @escaping (T?, Error?) -> Void) {
        let route = Route(uri: path, port: port, method: method, mimeType: mimeType, headers: headers, parameters: parameters, requiresAuth: usingAuth)
        send(requestFor: route, completion: completion)
    }
    
    /// Sends a request to the remote api setup in the HostConfiguration set on this object.
    ///
    /// - Parameters:
    ///   - routable: An object conforming to the Routable protocol that specifies all necessary route information for sending the request to the remote api.
    ///   - completion: A completion handler to run when the request is complete. The first parameter will be an object conforming to the Codable protocol so the parser will know which type to create when parsing the json response. The second parameter will be an Error type. If an error is returned the first parameter will be nil, the error will be an aggregate error type with the error status set and the parsed json error if one was returned from the api.
    public func send<T: Codable>(requestFor routable: Routable, completion: @escaping (T?, Error?) -> Void) {
        
        // check for network availability if configured
        if let reachability = reachability {
            guard reachability.status != .unreachable else {
                print("Remotli: Error - Host is not reachable.")
                completion(nil, NetworkError.networkUnreachable)
                return
            }
        } else {
            print("Remotli: Reachability is not configured, bypassing network connection check...")
        }
        
        // create a request object
        guard var request = requestFrom(routable) else {
            print("Remotli: Error - No request from routable")
            completion(nil, NetworkError.invalidRequest)
            return
        }
        
        // handle any request plugin preprocessing
        requestPlugin?.configure(&request, for: routable)

        // run the request
        session.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            
            guard let strongself = self else { return }
            
            // handle the response
            strongself.responsePlugin?.didReceive(response, data: data, error: error, forRequest: request, completion: completion)
            
        }).resume()
        
    }
    
    /// Generates a URLRequest from a Routable object.
    ///
    /// - Parameter routable: An object conforming to Routable that specifies all information necessary to send a request to a remote api.
    /// - Returns: If successful returns a URLRequest, else nil.
    internal func requestFrom(_ routable: Routable) -> URLRequest? {
        
        // get the url components from the base url configuration
        guard var components = config.baseURLComponents() else {
            print("Remotli: Error - No url components available to create URLRequest")
            return nil
        }
        
        // set the path and port components
        components.path = routable.uri
        components.port = routable.port
        
        // get the url from the components
        guard let url = components.url else {
            print("Remotli: Error - Unable to create request url from url components.")
            return nil
        }
        
        // generate a request with appropriate configuration setup
        var request = URLRequest(url: url, cachePolicy: routable.cachePolicy, timeoutInterval: routable.timeout)
        
        // set the request method from the configuration
        request.httpMethod = routable.method.rawValue
        
        return request
    }
    
    /// Adds a RequestPlugin instance to this class. If the requestPlugin property on this object is nil the passed in plugin will simply be set on the requestPlugin property. If an aggregate plugin is set, the passed in plugin will be added to the aggregate list, if a non-aggregate plugin is set, an aggregate will be created and both the existing plugin and the passed in plugin will be added to the aggregate plugin.
    ///
    /// - Parameter plugin: A plugin to set or add to this object to modify outgoing requests.
    public func addRequestPlugin(_ plugin: RequestPlugin) {
        
        if requestPlugin == nil {
            // if the request plugin is nil, assign the new plugin
            requestPlugin = plugin
            
        } else if let aggregate = requestPlugin as? AggregateRequestPlugin {
            // we already have an aggregate plugin, so add this to the aggregate
            aggregate.add(plugin)
            
        } else if let requestPlugin = requestPlugin{
            // the request plugin is set but not an aggregate, so switch to an aggregate and add both
            let aggregate = AggregateRequestPlugin.init(plugins: [requestPlugin, plugin])
            self.requestPlugin = aggregate
        }
    }
    
    /// Adds a ResponsePlugin instance to this class. If the responsePlugin property on this object is nil the passed in plugin will simply be set on the responsePlugin property. If an aggregate plugin is set, the passed in plugin will be added to the aggregate list, if a non-aggregate plugin is set, an aggregate will be created and both the existing plugin and the passed in plugin will be added to the aggregate plugin.
    ///
    /// - Parameter plugin: <#plugin description#>
    public func addResponsePlugin(_ plugin: ResponsePlugin) {
        
        if responsePlugin == nil {
            // if the response plugin is nil, simply assign the new plugin
            responsePlugin = plugin
            
        } else if let aggregate = responsePlugin as? AggregateResponsePlugin {
            // if we have an aggregate plugin, just add the new plugin to it
            aggregate.add(plugin)
            
        } else if let responsePlugin = responsePlugin {
            
            // the response plugin is set but not an aggregate, so switch to an aggregate and add both
            let aggregate = AggregateResponsePlugin.init(plugins: [responsePlugin, plugin])
            self.responsePlugin = aggregate
        }
    }
}

