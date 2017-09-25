//
//  LoggerPlugin.swift
//  nyt
//
//  Created by Irina Ernst on 9/24/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import Foundation
import Moya
import Result

final class LoggerPlugin: PluginType {
    
    // Formats the data for the response
    func JSONResponseDataFormatter(_ data: Data) -> Data {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data
        }
    }
    
    // MARK: Delegate methods
    public func didReceive(_ result: Result<Response, Moya.MoyaError>, target: TargetType) {
        var logString = ""
        switch result {
        case let .success(moyaResponse):
            let statusCode = moyaResponse.statusCode
            logString.append("\n💚 Successful Request!\n")
            logString.append("💚 Status Code: \(statusCode)\n")
            
            if let response = moyaResponse.response {
                logString.append("💚 Response:\n\(response.debugDescription)\n")
            }
            
            do {
                let jsonResponse = try moyaResponse.mapJSON()
                let prettyData = try JSONSerialization.data(withJSONObject: jsonResponse,
                                                            options: .prettyPrinted)
                
                if let prettyString = String(data: prettyData, encoding: .utf8) {
                    logString.append("💚 Response body:\n\(prettyString)\n")
                }
            } catch let error {
                NSLog(error.localizedDescription)
            }
            NSLog(logString)
            
        case let .failure(error):
            NSLog("💔 Unsuccessful Request: \(error.response.debugDescription)")
        }
    }
    
    
    // This is called immediately before a request is sent over the network (or stubbed).
    // Logs a cURL command for the request.
    
    func willSend(_ request: RequestType, target: TargetType) {
        guard let request = request.request,
            let method = request.httpMethod,
            let headers = request.allHTTPHeaderFields,
            let url = request.url else {
                return
        }
        
        var logString = " curl -X \(method)"
        
        headers.forEach({ (key, value) in
            logString.append(" -H \'\(key): \(value)\'")
        })
        
        logString.append(" URL: \'\(url.absoluteString)\'")
        
        switch method {
        case "PUT", "PATCH", "POST":
            if let body = request.httpBody,
                let bodyString = String(data: body, encoding: .utf8) {
                logString.append(" -d \'\(bodyString)\'")
            }
        default:
            logString.append("")
        }
        NSLog("\n💛 [%@]\n", logString)
    }
}

