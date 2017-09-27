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

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Table View Data Store
extension MainViewController: UITableViewDataSource {
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return booksToDisplay.count
        }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID,
                                                     for: indexPath) as! BookTableViewCell
    
            cell.book = booksToDisplay[indexPath.row]
            return cell
        }

}

// MARK: - Table View Configure
extension MainViewController: UITableViewDelegate{

    func configureView(){
        
        segmentedControl.layer.cornerRadius = 0
        segmentedControl.layer.masksToBounds = true
        
        configureTableView()
    }
    
    func configureTableView() {
        
        tableView.backgroundColor = Colors.black
        
        tableView.delegate = self
        tableView.dataSource = self

        // tableView.bounces = false
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

