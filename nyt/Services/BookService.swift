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
import JASON

struct BookService: NetworkServiceType {
    
    // MARK: - Properties
    //private(set) var realmDataStore: RealmDataStoreType
    private(set) var provider: MoyaProvider<NYT>
    
    // MARK: - Initializers(s)
    init(/*realmDataStore: RealmDataStoreType = RealmDataStore(),*/
         provider: MoyaProvider<NYT> = MoyaProvider<NYT>(endpointClosure: endpointClosure,
                                                         manager: DefaultAlamofireManager.sharedManager,
                                                         plugins: [LoggerPlugin()]))
    {
        //self.realmDataStore = realmDataStore
        self.provider = provider
    }
    
//    // Update user profile
//    func retrieveListsOfBooks(for target: NYT, dictionary: JSONDictionary) {
//        updateProfile(for: target) { result in
//            switch result {
//            case let .success(jsonResponse):
//                log.info("Success 💁🏻 -> updated user general settings: \(jsonResponse)")
//            case let .failure(error):
//                log.error("Error updating profile: \(error)")
//            }
//        }
//    }
    
    // Updates the user's profile information (general) for a target
    func retrieveListsOfBooks(for target: NYT,
                       completion: @escaping (Result<[Book], Moya.MoyaError>) -> Void) {
        
        request(target: target) { result in
            switch result {
            case let .success(json):
                let booksJson = json["results"] as! JSONArray
               // let jsonResponse: [String: AnyObject]?
//                if UserDefaults.standard.bool(forKey: "isTrainer") {
//                    jsonResponse = json["trainer"] as? [String: AnyObject]
//                } else {
//                    jsonResponse = json["client"] as? [String: AnyObject]
//                }
                //if let booksJson = json {
                print("Success 💁🏻 -> updated user general settings: \(booksJson)")
                
                var books = [Book]()
                for book in booksJson {
                    books.append(Book.deserialize(from: book))
                }
                    
                   // do {
//                        try self.realmDataStore.updateCurrentUser(AppStorage.userID, jsonDictionary: jsonResponse)
                        print("Success 💁🏻 -> updated user general settings: \(books)")
                        completion(.success(books))
//                    } catch let error {
//                        print("💔 \(error)")
//                    }
                //}
                //print("Success 💁🏻 -> updated user general settings: \(json)")
               // completion(.success(json))
            case let .failure(error):
                completion(.failure(MoyaError.underlying(error, nil)))
            }
        }
    }

    
}
