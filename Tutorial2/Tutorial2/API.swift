//
//  API.swift
//  Tutorial2
//
//  Created by Brabeeba Wang on 8/21/15.
//  Copyright (c) 2015 Brabeeba Wang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public protocol ResponseObjectSerializable {
    init?(response: NSHTTPURLResponse, representation: JSON)
}

extension Request {
    public func responseObject<T: ResponseObjectSerializable>(completionHandler: (NSURLRequest, NSHTTPURLResponse?, T?, NSError?) -> Void) -> Self {
        let responseSerializer = GenericResponseSerializer<T> { request, response, data in
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let (JSON: AnyObject?, serializationError) = JSONResponseSerializer.serializeResponse(request, response, data)
            
            if let response = response, JSON: AnyObject = JSON {
                return (T(response: response, representation: SwiftyJSON.JSON(JSON)), nil)
            } else {
                return (nil, serializationError)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

public protocol ResponseCollectionSerializable {
    static func collection(#response: NSHTTPURLResponse, representation: JSON) -> [Self]
}

extension Alamofire.Request {
    public func responseCollection<T: ResponseCollectionSerializable>(completionHandler: (NSURLRequest, NSHTTPURLResponse?, [T]?, NSError?) -> Void) -> Self {
        let responseSerializer = GenericResponseSerializer<[T]> { request, response, data in
            let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let (JSON: AnyObject?, serializationError) = JSONSerializer.serializeResponse(request, response, data)
            
            if let response = response, JSON: AnyObject = JSON {
                return (T.collection(response: response, representation: SwiftyJSON.JSON(JSON)), nil)
            } else {
                return (nil, serializationError)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
struct API {
    enum Router: URLRequestConvertible {
        static let baseURLString = "http://127.0.0.1:5000"
        
        case Inquiry(Int, Int)
        
        var method: Alamofire.Method {
            switch self {
            case .Inquiry(_, _):
                return .POST
            }
        }
        
        var path: String {
            switch self {
            case .Inquiry(_, _):
                return ""
            }
        }
        
        // MARK: URLRequestConvertible
        
        var URLRequest: NSURLRequest {
            let URL = NSURL(string: Router.baseURLString)!
            let mutableURLRequest = NSMutableURLRequest()
            
            if path != "" {
                mutableURLRequest.URL = URL.URLByAppendingPathComponent(path)
            } else {
                mutableURLRequest.URL = URL
            }
            
            mutableURLRequest.HTTPMethod = method.rawValue
            
            
            switch self {
            case .Inquiry(let startNum, let endNum):
                let parameters = ["startNum": startNum, "endNum": endNum]
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
            
            default:
                return mutableURLRequest
            }
        }
    }
}