//
//  Review.swift
//  nyt
//
//  Created by Irina Ernst on 9/24/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
import JASON

// Review Model
final class Review: Object, Deserializable {
    
    // MARK: - Properties
    @objc dynamic var book_review_link = ""
    @objc dynamic var first_chapter_link = ""
    @objc dynamic var sunday_review_link = ""
    @objc dynamic var article_chapter_link = ""
    
    // MARK: - Primary key
    override static func primaryKey() -> String? {
        return "book_review_link"
    }
    
    // MARK: - Deserializer
    static func deserialize(from json: JSONDictionary) -> Review {
        let book_review_link = json["book_review_link"]
        let first_chapter_link = json["first_chapter_link"]
        let sunday_review_link = json["sunday_review_link"]
        let article_chapter_link = json["article_chapter_link"]
        
        return Review(value: ["book_review_link": book_review_link,
                              "first_chapter_link": first_chapter_link,
                              "sunday_review_link": sunday_review_link,
                              "article_chapter_link": article_chapter_link
            ])
    }
}
