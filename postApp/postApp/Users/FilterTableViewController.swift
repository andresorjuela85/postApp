//
//  FilterTableViewController.swift
//  postApp
//
//  Created by Andres Orjuela on 18/01/23.
//

import UIKit

class FilterTableViewController: UITableViewController {
    
    var filteredUsers: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "reuseCell")
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredUsers.count == 0 {
            return 1
        }
        else {
            return filteredUsers.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if filteredUsers.count == 0 {
            
            let cell = UITableViewCell()
            
            cell.textLabel?.text = "List is empty"
            cell.textLabel?.font = .systemFont(ofSize: 25)
            
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath) as? UserCell else {
                
                return UITableViewCell()
            }
            
            cell.configure(user: filteredUsers[indexPath.row])
            return cell
        }
        
    }
}
