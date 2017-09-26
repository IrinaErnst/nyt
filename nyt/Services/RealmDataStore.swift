//
//  RealmDataStore.swift
//  nyt
//
//  Created by Irina Ernst on 9/26/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDataStore: RealmDataStoreType {
    
    // MARK: - Properties
    let realm: Realm!
    
    // MARK: Initializer(s)
    init(realm: Realm) {
        self.realm = realm
    }
}
