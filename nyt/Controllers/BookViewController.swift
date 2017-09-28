//
//  BookViewController.swift
//  nyt
//
//  Created by Irina Ernst on 9/27/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var bookView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var bookDescriptionTextField: UITextView!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var bestsellerDateLabel: UILabel!
    @IBOutlet weak var currentRankLabel: UILabel!
    @IBOutlet weak var rankLastWeekLabel: UILabel!
    @IBOutlet weak var numberWeeksOnTheListLabel: UILabel!
    
    // MARK: - Propertie(s)
    var book: Book? 
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        configureBookView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "amazonSegue") {
            if let webViewController = segue.destination as? WebViewController {
                webViewController.amazonLink = book?.amazon_product_url
                webViewController.navigationItem.title = book?.book_details?.title
            }
        }
    }


}

// MARK: - Configure BookViewController
extension BookViewController {
    
    func configureView() {
        bookDescriptionTextField.isUserInteractionEnabled = false
        configureBookView()
    }
    
    func configureBookView() {
        if let book = book {
            titleLabel.text = book.book_details?.title
            authorNameLabel.text = "by " + (book.book_details?.author ?? "Unknown Author")
            bookDescriptionTextField.text = book.book_details?.full_description
            publisherLabel.text = book.book_details?.publisher
            publishedDateLabel.text = book.published_date
            bestsellerDateLabel.text = book.bestsellers_date
            currentRankLabel.text = String(describing: book.rank)
            rankLastWeekLabel.text = String(describing: book.rank_last_week)
            numberWeeksOnTheListLabel.text = String(describing: book.weeks_on_list)
        }
    }
    
}
