//
//  UserCell.swift
//  postApp
//
//  Created by Andres Orjuela on 18/01/23.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    func configure(user: User) {
        
        nameLabel.text = user.name
        phoneLabel.text = user.phone
        emailLabel.text = user.email
    }
}
