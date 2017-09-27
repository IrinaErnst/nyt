//
//  BookTableViewCell.swift
//  nyt
//
//  Created by Irina Ernst on 9/27/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var book: Book? {
        
        didSet{
            
            if let rank = book?.rank {
                rankLabel.text = (String(rank) + ".").uppercased()
            }
            
            if let title = book?.book_details?.title {
                bookNameLabel.text = title
            }
            
            if let authorName = book?.book_details?.author {
                authorNameLabel.text = "by " + authorName
            }
            
        }
    }
    
}



