//
//  Book_details.swift
//  nyt
//
//  Created by Irina Ernst on 9/24/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
import JASON

// Book Details Model
final class Book_details: Object, Deserializable {
    
    // MARK: - Properties
    @objc dynamic var primary_isbn13 = ""
    @objc dynamic var title = ""
    @objc dynamic var full_description = ""
    @objc dynamic var contributor = ""
    @objc dynamic var author = ""
    @objc dynamic var contributor_note = ""
    @objc dynamic var price = 0
    @objc dynamic var age_group = ""
    @objc dynamic var publisher = ""
    
    // MARK: - Primary key
    override static func primaryKey() -> String? {
        return "primary_isbn13"
    }
    
    // MARK: - Deserializer
    static func deserialize(from json: JSONDictionary) -> Book_details {
        let primary_isbn13 = json["primary_isbn13"]
        let title = json["title"]
        let full_description = json["description"]
        let contributor = json["contributor"]
        let author = json["author"]
        let contributor_note = json["contributor_note"]
        let price = json["price"]
        let age_group = json["age_group"]
        let publisher = json["publisher"]
        
        return Book_details(value: ["primary_isbn13": primary_isbn13,
                                    "title": title,
                                    "full_description": full_description,
                                    "contributor": contributor,
                                    "author": author,
                                    "contributor_note": contributor_note,
                                    "price": price,
                                    "age_group": age_group,
                                    "publisher": publisher
            ])
    }
}
