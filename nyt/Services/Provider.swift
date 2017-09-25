//
//  Provider.swift
//  nyt
//
//  Created by Irina Ernst on 9/22/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import Foundation
import Moya


func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}


// MARK: - Target
enum NYT {
    /*
     GET  /lists.{format}
     GET  /lists/best-sellers/history.json
     GET  /lists/names.{format}
     GET  /lists/overview.{format}
     GET  /lists/{date}/{list}.json
     GET  /reviews.{format}
     */
    
    // GET  /lists.{format}
    case retrieveLists(dictionary: JSONDictionary)
}

// MARK: - Endpoint closure.  Adds the API key to the header for the necessary targets.
let endpointClosure = { (target: NYT) -> Endpoint<NYT> in
    let defaultEndpoint = MoyaProvider<NYT>.defaultEndpointMapping(for: target)
    
    //if target.needsToken {
    //    return defaultEndpoint.adding(parameters: ["api-key": Constants.NewYorkTimes.books],
            //parameters: [:],
      //          httpHeaderFields: ["Content-Type": "application/json"])
//    } else {
        return defaultEndpoint.adding(newHTTPHeaderFields: ["Content-Type": "application/json"])
//    }
}

// MARK: Conformance to TargetType
extension NYT: TargetType {
    
    // MARK: Header
    var headers: [String : String]? { return ["api-key": Constants.NewYorkTimes.books]}
    
    // MARK: Base URL
    var baseURL: URL { return URL(string: Constants.Networking.baseURLString)! }
    
    // MARK: - Path
    var path: String {
        switch self {
            
        // GET List of books
        case .retrieveLists(dictionary: _):
            return "/lists"
        }
    }


    // MARK: - Method
    var method: Moya.Method {
        switch self {
        case .retrieveLists(dictionary: _):
            return .get
        }
    }

    // MARK: - Task
    var task: Task {
        switch self {
        case .retrieveLists(let dictionary):
            return .requestParameters(parameters: dictionary, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
        
    // MARK: - Parameters
    var parameters: [String: Any]? {
        switch self {
            
        // Signup & login
        case .retrieveLists(let dictionary):
            return dictionary
        }
    }
    
    var parameterEncoding: ParameterEncoding {
//        switch self {
//        case .retrieveLists:
//            //return URLEncoding.default
//            return JSONEncoding.default
//        default:
            return JSONEncoding.default
//        }
    }
    
    // MARK: - Sample Data.
    // TODO: - Stub network responses
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
}
