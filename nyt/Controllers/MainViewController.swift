//
//  TableViewController.swift
//  nyt
//
//  Created by Irina Ernst on 9/22/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class MainViewController: UIViewController {

    // Mark: - IBOutlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private lazy var bookService: BookService = BookService()
    let realm = try! Realm()
    let cellID = "bookCell"
    var allBooks: [Book] = []
    var booksToDisplay: [Book] = []
    var selectedBook: Book?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Networking
    func retrieveBestsellersList() {
        let target = NYT.retrieveLists(dictionary: ["list":"e-book-fiction"])
        bookService.retrieveListsOfBooks(for: target,
                                         completion: { [unowned self] result in
                                            switch result {
                                            case .success(let books):
                                                // TODO: display result in Table view
                                                self.allBooks = books
                                                self.booksToDisplay = books
                                                self.tableView.reloadData()
                                                return
                                            case let .failure(error):
                                                print(error)
                                                return
                                            }
        })
    }
}

// MARK: - Table View Data Store
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksToDisplay.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID,
                                                 for: indexPath) as! BookTableViewCell

        cell.book = booksToDisplay[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "bookSegue") {
            if let bookViewController = segue.destination as? BookViewController {
                bookViewController.book = selectedBook
            }
        }
    }

}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookViewController  = BookViewController()
        selectedBook = booksToDisplay[indexPath.row]
        bookViewController.book = selectedBook

        performSegue(withIdentifier: "bookSegue", sender: self)
    }
}


// MARK: - Table View Configure
extension MainViewController {

    func configureView(){
        configureTableView()
        retrieveBestsellersList()
    }
    
    func configureTableView() {
        tableView.backgroundColor = Colors.black
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.tableFooterView = UIView(frame: .zero)
    }
}

