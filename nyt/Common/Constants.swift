//
//  Constants.swift
//  nyt
//
//  Created by Irina Ernst on 9/22/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import Foundation

// App constants
struct Constants {
    
    // MARK: - private initializer
    private init() {}
    
    struct Networking {
        private init() {}
        static let baseURLString = "https://api.nytimes.com/svc/books/v3"
    }
    
    struct NewYorkTimes {
        private init() {}
        static let books = "d984163307fe4c54b73fb43630fffe65"
    }
}
