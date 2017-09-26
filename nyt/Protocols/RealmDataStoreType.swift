//
//  RealmDataStoreType.swift
//  nyt
//
//  Created by Irina Ernst on 9/26/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import Foundation
import RealmSwift

// A Repository for Realm Objects
protocol RealmDataStoreType {
    var realm: Realm! { get }
    func fetchAllObjects<T: Object>(type: T.Type) -> Results<T>?
    func fetchObjectById<T: Object>(id: Int, type: T.Type) -> T?
    func insertOrUpdateObject(object: Object) throws
    func insertOrUpdateObjectsFromArray(objects: [Object]) throws
    func deleteObjectById<T: Object>(id: Int, type: T.Type) throws
    func clearAllObjects()
}

extension RealmDataStoreType {
    
    // Fetches Realm Results of the provided Object Type
    func fetchAllObjects<T: Object>(type: T.Type) -> Results<T>? {
        let results = realm.objects(type)
        return results
    }
    
    // Fetches Realm Results by id of the provided Object Type
    func fetchObjectById<T: Object>(id: Int, type: T.Type) -> T? {
        let results = realm.object(ofType: type, forPrimaryKey: id)
        return results
    }
    
    // Inserts or updates a Realm Object
    func insertOrUpdateObject(object: Object) throws {
        do {
            try realm.write {
                realm.add(object, update: true)
            }
        } catch let error {
            print(error)
            throw error
        }
    }
    
    // Inserts or updates an array of Realm Objects
    func insertOrUpdateObjectsFromArray(objects: [Object]) throws {
        do {
            try realm.write {
                realm.add(objects, update: true)
            }
        } catch let error {
            print(error)
            throw error
        }
    }
    
    // Deletes a Realm Object by id
    func deleteObjectById<T: Object>(id: Int, type: T.Type) throws {
        let results = fetchObjectById(id: id, type: type)
        if let results = results {
            do {
                try realm.write {
                    realm.delete(results)
                }
            } catch let error {
                print(error)
                throw error
            }
        }
    }
    
    // Clears all objects from the Realm
    func clearAllObjects() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let error {
            print(error)
        }
    }
}
