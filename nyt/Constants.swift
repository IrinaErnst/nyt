//
//  Constants.swift
//  nyt
//
//  Created by Irina Ernst on 9/22/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import Foundation
import FacebookCore

// App constants
struct Constants {
    
    // MARK: - private initializer.  Safeguard against developers attempting to instantiate.
    private init() {}
    
    struct Networking {
        private init() {}
        static let baseURLString = "http://..."
    }
    
    struct NewYorkTimes {
        private init() {}
        static let books = "d984163307fe4c54b73fb43630fffe65"
    }
}
