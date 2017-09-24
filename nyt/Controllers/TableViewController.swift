//
//  TableViewController.swift
//  nyt
//
//  Created by Irina Ernst on 9/22/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    // MARK: - Properties
    private lazy var bookService: BookService = BookService()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let target = NYT.retrieveLists(dictionary: ["":""])
        
        bookService.retrieveListsOfBooks(for: target,
                                         completion: { result in
            switch result {
            case .success(let result):
                print("❤️❤️❤️ \(result)")
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

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
