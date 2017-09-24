//
//  NetworkServiceType.swift
//  nyt
//
//  Created by Irina Ernst on 9/23/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import Moya
import Result
import JASON
import Realm

// This contains the base networking methods that make use of the MoyaProvider
protocol NetworkServiceType {
    var provider: MoyaProvider<NYT> { get }
    var realmDataStore: RealmDataStoreType { get }
    func request(target: NYT, completion: @escaping (Result<JSONDictionary, Moya.MoyaError>) -> Void)
    func requestObject<T: JSONDeserializable>(target: NYT, completion: @escaping (Result<T,
        Moya.MoyaError>) -> Void)
}

extension NetworkServiceType {
    
    // Makes a request to the target via the provider.
    func request(target: NYT, completion: @escaping (Result<JSONDictionary, Moya.MoyaError>) -> Void) {
        
        self.provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let json = try response.mapJSON()
                    let jsonDictionary = JSON(json).dictionaryValue
                    completion(.success(jsonDictionary))
                } catch {
                    log.error(Moya.MoyaError.jsonMapping(response))
                    completion(.failure(Moya.MoyaError.jsonMapping(response)))
                }
            case let .failure(error):
                log.error(error)
                completion(.failure(Moya.MoyaError.underlying(error)))
            }
        }
    }

}

