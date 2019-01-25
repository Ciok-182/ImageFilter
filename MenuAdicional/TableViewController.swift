//
//  TableViewController.swift
//  MenuAdicional
//
//  Created by Jorge Encinas on 1/24/19.
//  Copyright © 2019 Jorge. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    
    let filters = [ "Red","Blue","Green","Yellow"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath)
        
        cell.textLabel?.text = filters[indexPath.row]
        return cell
    }
    
}
