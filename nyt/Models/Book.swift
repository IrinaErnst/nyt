//
//  Book.swift
//  nyt
//
//  Created by Irina Ernst on 9/24/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
import JASON

// Book Model
final class Book: Object, Deserializable {
    @objc dynamic var list_name = ""
    @objc dynamic var display_name = ""
    @objc dynamic var published_date = ""
    @objc dynamic var bestsellers_date = ""
    @objc dynamic var rank = 0
    @objc dynamic var rank_last_week = 0
    @objc dynamic var weeks_on_list = 0
    @objc dynamic var asterisk = 0
    @objc dynamic var dagger = 0
    @objc dynamic var amazon_product_url = ""
    @objc dynamic var book_details: Book_details?
    @objc dynamic var review: Review?
    
    override static func primaryKey() -> String? {
        return "list_name"
    }
    
    static func deserialize(from json: JSONDictionary) -> Book {
        let list_name = json["list_name"]
        let display_name = json["display_name"]
        let bestsellers_date = json["bestsellers_date"]
        let published_date = json["published_date"]
        let rank = json["rank"]
        let rank_last_week = json["rank_last_week"]
        let weeks_on_list = json["weeks_on_list"]
        let asterisk = json["asterisk"]
        let dagger = json["dagger"]
        let amazon_product_url = json["amazon_product_url"]
        
        var book_details = Book_details()
        if let bookDetailsJson = json["book_details"] as? JSONDictionary {
            book_details = Book_details.deserialize(from: bookDetailsJson)
        }
        var review = Review()
        if let reviewJson = json["reviews"] as? JSONDictionary {
            review = Review.deserialize(from: reviewJson)
        }
        
        return Book(value: ["list_name": list_name,
                            "display_name": display_name,
                            "bestsellers_date": bestsellers_date,
                            "published_date": published_date,
                            "rank": rank,
                            "rank_last_week": rank_last_week,
                            "weeks_on_list": weeks_on_list,
                            "asterisk": asterisk,
                            "dagger": dagger,
                            "amazon_product_url": amazon_product_url,
                            "book_details": book_details,
                            "review": review
                               
            ])
    }
}

