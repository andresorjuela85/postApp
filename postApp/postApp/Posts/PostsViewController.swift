//
//  PostsViewController.swift
//  postApp
//
//  Created by Andres Orjuela on 18/01/23.
//

import UIKit

class PostsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var postsTableView: UITableView!
    
    var viewModel: PostsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
        viewModel?.getPosts()
        setupTable()
    }
    
    func setupBinding() {
        
        viewModel?.loading = { [weak self] isLoading in
            
            if isLoading {
                self?.showLoader()
            } else {
                self?.removeLoader()
            }
        }
        
        viewModel?.onGetPost = { [weak self] in
            self?.setupView()
            self?.postsTableView.reloadData()
        }
    }
    
    func setupView() {
        nameLabel.text = viewModel?.user.name
        phoneLabel.text = viewModel?.user.phone
        emailLabel.text = viewModel?.user.email
    }
    
    func setupTable() {
        postsTableView.dataSource = self
        postsTableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "reuse")
    }
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.posts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuse", for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        
        cell.configure(post: viewModel?.posts[indexPath.row])
        return cell
    }
}
