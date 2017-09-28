//
//  BookService.swift
//  nyt
//
//  Created by Irina Ernst on 9/23/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import Foundation
import Moya
import Result
import RealmSwift
import Realm
import JASON

struct BookService: NetworkServiceType {
    
    // MARK: - Properties
    private(set) var realmDataStore: RealmDataStoreType
    private(set) var provider: MoyaProvider<NYT>
    
    // MARK: - Initializers(s)
    init(realmDataStore: RealmDataStoreType = RealmDataStore(),
         provider: MoyaProvider<NYT> = MoyaProvider<NYT>(endpointClosure: endpointClosure,
                                                         manager: DefaultAlamofireManager.sharedManager,
                                                         plugins: [LoggerPlugin()]))
    {
        self.realmDataStore = realmDataStore
        self.provider = provider
    }
    
    // Retrive books information for a target
    func retrieveListsOfBooks(for target: NYT,
                       completion: @escaping (Result<[Book], Moya.MoyaError>) -> Void) {
        
        request(target: target) { result in
            switch result {
            case let .success(json):
                let booksJson = json["results"] as! JSONArray
                
                var books = [Book]()
                for book in booksJson {
                    books.append(Book.deserialize(from: book))
                }
                    
                do {
                    try self.realmDataStore.insertOrUpdateObjectsFromArray(objects: books)
                    completion(.success(books))
                } catch let error {
                    print("💔 \(error)")
                }
            case let .failure(error):
                completion(.failure(MoyaError.underlying(error, nil)))
            }
        }
    }

    
}
