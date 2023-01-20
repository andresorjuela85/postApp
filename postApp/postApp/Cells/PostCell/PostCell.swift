//
//  PostCell.swift
//  postApp
//
//  Created by Andres Orjuela on 18/01/23.
//

import UIKit

class PostCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    func configure(post: Post?) {
        
        titleLabel.text = post?.title
        bodyLabel.text = post?.body
    }
}
