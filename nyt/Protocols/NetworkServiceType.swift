//
//  NetworkServiceType.swift
//  nyt
//
//  Created by Irina Ernst on 9/23/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import Foundation
import Moya
import Result
import JASON
import Realm

// This contains the base networking methods that make use of the MoyaProvider
protocol NetworkServiceType {
    var provider: MoyaProvider<NYT> { get }
    //var realmDataStore: RealmDataStoreType { get }
    func request(target: NYT, completion: @escaping (Result<JSONDictionary, Moya.MoyaError>) -> Void)
    func requestObject<T: JSONDeserializable>(target: NYT,
                                              completion: @escaping (Result<T, Moya.MoyaError>) -> Void)
}

extension NetworkServiceType {
    
    // Request for an JSONDeserializableto the target via the provider.
    func request(target: NYT, completion: @escaping (Result<JSONDictionary, Moya.MoyaError>) -> Void) {
        
        self.provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let json = try response.mapJSON()
                    let jsonDictionary = JSON(json).dictionaryValue
                    completion(.success(jsonDictionary))
                } catch {
                    print(Moya.MoyaError.jsonMapping(response))
                    completion(.failure(Moya.MoyaError.jsonMapping(response)))
                }
            case let .failure(error):
                print("💔 \(error)")
                completion(.failure(Moya.MoyaError.underlying(error, nil)))
            }
        }
    }
    
    // Request for an object that conforms to JSONDeserializable
    func requestObject<T: JSONDeserializable>(target: NYT,
                                              completion: @escaping (Result<T, Moya.MoyaError>) -> Void) {
        self.request(target: target) { result in
            switch result {
            case let .success(json):
                do {
                    let object = try T(jsonRepresentation: json)
                    completion(.success(object))
                } catch let error {
                    completion(.failure(Moya.MoyaError.underlying(error, nil)))
                }
            case let .failure(error):
                print("💔 \(error)")
                completion(.failure(error))
            }
        }
    }

}

