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
    dynamic var primary_isbn13 = ""
    dynamic var title = ""
    dynamic var description = ""
    dynamic var contributor = ""
    dynamic var author = ""
    dynamic var contributor_note = ""
    dynamic var price = 0
    dynamic var age_group = ""
    dynamic var publisher = ""
    
    override static func primaryKey() -> String? {
        return "primary_isbn13"
    }
    
    static func deserialize(from json: JSONDictionary) -> Book_details {
        let primary_isbn13 = json["primary_isbn13"]
        let title = json["title"]
        let description = json["description"]
        let contributor = json["contributor"]
        let author = json["author"]
        let contributor_note = json["contributor_note"]
        let price = json["price"]
        let age_group = json["age_group"]
        let publisher = json["publisher"]
        
        return Book_details(value: ["primary_isbn13": primary_isbn13,
                                    "title": title,
                                    "description": description,
                                    "contributor": contributor,
                                    "author": author,
                                    "contributor_note": contributor_note,
                                    "price": price,
                                    "age_group": age_group,
                                    "publisher": publisher
            ])
}
