# Remotli Framework

Remotely is a Swift framework designed to simplify the process of loading remote json resources from a web based api and converting them into model objects within iOS applications.

## Features
- Written in Swift 4.0
- Simple to use
- Highly Configurable

## Installation

1. Add the master spec repo source url
   - source 'https://github.com/CocoaPods/Specs.git'
2. Specify the correct version for the target(s) in the podfile.
   - pod 'Remotli', '~> 1.0'
3. Run pod update (may need to run pod install first)
4. Open the workspace, clean, and build

Example podfile
```

platform :ios, '10.0'
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'

# Example dependencies
target 'MyAppTargetName' do
    
    pod 'Remotli', '~> 1.0.0'

end
```

## Usage

There are several ways you can make use of Remotely. It is designed to work out of the box with no setup, but provides the flexibility to be highly configured if needed.

### The simplest use case

The simplest way to use Remotely involves 2 steps. 
This assumes that you already have a data model within your app corresponding to the json response you expect from your remote api. Your model object must conform to the `Codable` protocol in order to be parsed in Remotely. 
* Declare an instance of Remotli with your host name. 
  * It should only be the host name, without the scheme prefix.
  * By using the `Remotli(host:)` initializer the scheme is automatically set to https://.
* Call 'send' on your Remotli instance, passing in any required arguments. 
  * The completion handler will use named parameters with the first being your model object type, and the second the Error type.
  * Both parameters are optional types.

```Swift

/// Defines a sample user model for parsing with JSON.
/// Note the conformance to the Codable protocol.
public class User: Codable {
    public var identifier: String
    public var firstName: String
    public var lastName: String
    public var email: String
    public var phone: String?
    public var birthday: String?
    public var isPendingVerification: Bool = false
}

extension User {
    // If your remote api uses different json keys for some values than you plan to use
    // for your local model object, you will need to define coding keys that map from the
    // local model to the remote api model. The case name should match your local model
    // var names, and the string key should match the remote api key for this value.
    // If your local var name matches the remote api key do not assign a string value.
    enum CodingKeys: String, CodingKey {
        case identifier
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case phone
        case birthday
        case isPendingVerification = "pending_verification"
    }
}

/// Create an instance of Remotli using your host name. 
/// This convenience init defaults the scheme to https.
internal var myHost = Remotli(host: "my-remote-api.com")

/// Call 'send' on your remote host, passing in any required parameters.
/// Note the use of the custom 'User' model type as the type for the first
/// completion parameter.
myHost.send(
    "/user/login", 
    port: nil, 
    method: HTTPMethod.get, 
    mimeType: MimeType.applicationJson, 
    headers: nil, 
    parameters: ["username": username, "password": password], 
    usingAuth: false, 
    completion: { (user: User?, error: Error?) in

        // validate the response, check for errors
        guard let user = user, error == nil else {
            // do something with the error here
            return
        }

        // do something with user
    })

```

If you need custom behaviors or greater flexibility in your implementation, keep reading. 

## Overview

This section provides a high level overview of how this framework operates and the options available for greater configuration and customization to fit your needs.

#### Routes
Remotli is designed around Routables, or objects conforming to the ` Routable ` protocol that represent resources on a remote api. 
Remotli contains a default implementation of a Routable, called a Route. The Route object encapsulates all the information needed to generate a URL request to a remote service.

The ` Routable ` protocol and ` Route ` object look like this:
```Swift

public protocol Routable {
    var uri: String { get }
    var port: Int? { get }
    var method: HTTPMethod { get }
    var mimeType: MimeType { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var requiresAuth: Bool { get }

    var timeout: TimeInterval { get }
    var cachePolicy: URLRequest.CachePolicy { get }
}

extension Routable {
    public var timeout: TimeInterval {
        return 60
    }

    public var cachePolicy: URLRequest.CachePolicy {
        return .useProtocolCachePolicy
    }

    public func route() -> Route {
        return Route(uri: uri, port: port, method: method, mimeType: mimeType, headers: headers, parameters: parameters, requiresAuth: requiresAuth)
    }
}

open class Route: Routable {
    public var uri: String
    public var port: Int?
    public var method: HTTPMethod
    public var mimeType: MimeType
    public var headers: [String : String]?
    public var parameters: [String : Any]?
    public var requiresAuth: Bool

    public init(uri: String, port: Int? = nil, method: HTTPMethod = .post, mimeType: MimeType = .applicationJson, headers: [String: String]? = nil, parameters: [String: Any]? = nil, requiresAuth: Bool = false) {
        self.uri = uri
        self.port = port
        self.method = method
        self.mimeType = mimeType
        self.headers = headers
        self.parameters = parameters
        self.requiresAuth = requiresAuth
    }
}

```

#### Remotely

The main class that handles the processing of Routes and sending requests is the ` Remotli ` class.
This class provides the default implementation for the ` Remotely ` protocol, that defines the behaviors required for Route handling.

The Remotely protocol specifies the interface for handling Routables and provides two functions for sending requests to the configured remote host. 

```Swift

// Option 1
// takes parameters that are used to create a Route object behind the scenes, then passes the route to the 'send' function
// specified in option 2.
myHost.send(_ path:port:method:mimeType:headers:parameters:usingAuth:completion:)

// Option 2
// takes a route object directly
myHost.send(requestFor:completion:)

```

The first function provides for the simplest use of Remotli, because you don't have to touch Routables or Route objects directly at all.
You simply specify the relative path and provide any values needed by the remote host.
```Swift

myHost.send(
    "/user/login", 
    port: nil, 
    method: HTTPMethod.get, 
    mimeType: MimeType.applicationJson, 
    headers: nil, 
    parameters: ["username": username, "password": password], 
    usingAuth: false, 
    completion: { (user: User?, error: Error?) in
    })

```

The second function allows for more flexibility by accepting the default Route object or other Routable objects you define and customize.
The following 4 examples demonstrate possible ways to generate your routes, depending on your needs.

##### Custom Routables

This  demonstrates the creation of custom routes using the default ` Route ` class provided by Remotli.
```Swift

// note that parameters where the default values are sufficient are omitted
let route = Route(
    uri: "/api/mas/0.2/app_config/fetch",
    mimeType: .applicationFormUrlEncoded,
    parameters: defaultParameters()
    )
    
// call 'send(requestFor:completion:)' passing in the route
myHost.send(requestFor: route, completion: completion)

```

If you prefer to encapsulate your routes, or need custom logic in your route generation, you can define your own classes conforming to the ` Routable ` protocol.
```Swift

// This demonstrates a custom class conforming to the ` Routable ` protocol to create a custom route.
class ConfigurationRoute: Routable {

    var method: HTTPMethod = .post
    var uri: String =  "/api/mas/0.2/app_config/fetch"
    var mimeType: MimeType = .applicationFormUrlEncoded
    var port: Int?
    var headers: [String: String]?
    var parameters: [String: Any]?
    var requiresAuth: Bool = false

    init(parameters: [String: Any]?) {
        self.parameters = parameters
    }
}

// send the request using the custom route
send(requestFor: 
        ConfigurationRoute(parameters: ["app_id": "MY_APP_ID", "token": ""]), 
        completion: completion
    )

```

If you have a remote service with an endpoint that can provide different responses based on different passed in parameters, and the variables (defined by the Routable) do not need to be changed or updated at any point (get only) you could define your route using an enum conforming to the ` Routable ` protocol.
```Swift

// This is a sample route that makes use of an enum to generate differing parameter
// options sent to the same token endpoint depending on the type of token desired.
enum TokenRoute: Routable {

    // each case in this route represents a different token type that can
    // be requested from this api route or endpoint. All cases share the same
    // method, uri, mimeType and headers but send different parameters to the
    // remote host.
    case anonymous
    case refresh(token: String)
    case credential
    case social

    var method: HTTPMethod {
        return .post
    }

    var uri: String {
        return "/v1/tokens"
    }

    var mimeType: MimeType {
        return .applicationJson
    }

    var port: Int? {
        return nil
    }

    var headers: [String: String]? {
        return [       
            "Accept-Encoding": "gzip",
            "Accept-Language": "en-us",
            "Accept": "application/json"
        ]
    }

    var parameters: [String: Any]? {
        switch self {
        case .anonymous: return ["type": "ANONYMOUS"]
        case .refresh(let token): return ["type": "REFRESH", "credential": token]
        case .credential: return ["type": "CREDENTIAL"]
        case .social: return ["type": "SOCIAL"]
        }
    }

    var requiresAuth: Bool {
        return false
    }
}

// a sample function that might make use of the custom TokenRoute might look like this

// Fetches the token from the remote host, making use of a route initializer 
// and specifying that an anonymous token is being requested.
func getToken(completion: @escaping (Token?, Error?) -> Void) {
    send(requestFor: TokenRoute.anonymous, completion: completion)
}

```

You can also define a subclass of the ` Route ` class to provide your own custom behavior for routes. 

This example demonstrates a UserRoute class that makes use of static vars to specify default route information, and uses static functions to create and return instances of the UserRoute specifically for logging in a user. Note how the static initializer generates custom parameters for the request and the login function simply has to call the static initializer and provide the values that get set in the parameters.
```Swift

// Defines a class based route that uses static functions as custom initializers.
// This is an alternate method to using an enum.
class UserRoute: Route {
    
    // static vars define default parameters for static route initializers
    static let uri: String = "/v1/tokens"
    static let method: HTTPMethod = .post
    static let mimetype: MimeType = .applicationJson
    static var defaultHeaders: [String: String] = [
        "Accept-Encoding": "gzip",
        "Accept-Language": "en-us",
        "Accept": "application/json"
        ]
}

extension UserRoute {

    // custom Route initializer that sets up a login route with custom parameters
    static func login(username: String, password: String) -> UserRoute {
        return UserRoute(
            uri: uri,
            port: nil,
            method: method,
            mimeType: mimetype,
            headers: defaultHeaders,
            parameters: [
                "name": username,
                "credentialType": "CREDENTIAL",
                "credential": password
            ],
            requiresAuth: false
        )
    }
}

// a sample function that might make use of the custom UserRoute might look like this

// Logs in to this remote host and returns a User model object if successful.
func login(username: String, password: String, completion: @escaping (User?, Error?) -> Void) {
    let route = UserRoute.login(username: username, password: password)
    send(requestFor: route, completion: completion)
}

```

##### Custom Remotli Implementations

There may be cases where you need additional custom behaviors that are not provided when using the default ` Remotli ` class. 

You might also want to encapsulate all calls to a specific remote web service to have your own internal representation of a remote api. There are a couple ways to achieve this.

You can implement your own encapsulated service api by subclassing the ` Remotli ` class. For instance if you wanted to access the Flickr api you could create a custom subclass specifically for sending requests to Flickr and write all your access functions within this subclass.

If you want even more granular control or custom behavior you can create your own class conforming to the ` Remotely ` protocol and implement whatever behavior you require.


The following example demonstrates a custom remote web service that subclasses ` Remotli ` since it requires additional configuration.
It encapsulates all calls for the remote service within the subclass.
Additional configuration is handled by overriding the 'setup()' function. The setup function is implemented in Remotli as a hook for subclasses to customize the class and is called immediately following initialization.
```Swift

class MySiteAPI: Remotli {
    
    // provide a convenience initializer if you want to encapsulate the url for your host
    // within this class (not required).
    // if you do this you can initialize simply by declaring
    //
    // let myApi = MySiteAPI()
    //
    convenience init() {
        self.init(host: "my-host-api.com")
    }

    // Sets up an additional basic auth plugin with username/password.
    // This will configure all outgoing requests to this remote host with an
    // Authentication header set with a basic auth token value.
    override func setup() {
        addRequestPlugin(BasicAuthPlugin.init(username: "my-basic-auth-username", password: "secret-password"))
    }

    // Fetches the token from this remote host, making use of a route initializer and
    // specifying that an anonymous token is being requested.
    func getToken(completion: @escaping (Token?, Error?) -> Void) {
        send(requestFor: TokenRoute.anonymous, completion: completion)
    }

    // Logs in to this remote host and returns a User model object if successful.
    // Makes use of a route initializer for convenience.
    func login(username: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        let route = UserRoute.login(username: username, password: password)
        send(requestFor: route, completion: completion)
    }
}

```

#### Supporting Multiple Remote Services

If your application accesses multiple remote web services, you might find it useful to create a factory class to encapsulate configuration settings for the remote hosts.

One way to accomplish this is by doing the following.
```Swift

// The default scheme configuration setting is .https.
class RemoteSites {

    // Defines a remote host with an explicit .https scheme set as an example, if not specified https is set by default.
    static func google() -> Configuration {
        return Configuration(scheme: .https, host: "google.com")
    }

    // Defines a second remote host.
    static func flickr() -> Configuration {
        return Configuration(host: "flickr.com")
    }
}

// then in the class where your network access is handled you could setup your remote clients like this
internal var google: GoogleClient
internal var flickr: FlickrClient

init() {
    setupRemoteSites()
}

func setupRemoteSites() {

    // setup and configure custom url session for google service
    let urlConfig = URLSessionConfiguration.init()
    urlConfig.allowsCellularAccess = true
    urlConfig.httpCookieAcceptPolicy = .always
    let urlSession = URLSession.init(configuration: urlConfig)
    
    // setup google with the custom url session
    google = Remotli(configuration: RemoteSites.google(), session: urlSession, useReachability: false)
    
    // setup flickr with URLSession.shared and useReachability = true by default
    flickr = Remotli(configuration: RemoteSites.flickr())
}

```



## Planned Features
- [ ] Support for XML
- [ ] Greater configuration options
- [ ] Support for custom error types

## Dependencies


## Requirements

- iOS 10.0+
- Xcode 9
- Swift 4
- [CocoaPods]

