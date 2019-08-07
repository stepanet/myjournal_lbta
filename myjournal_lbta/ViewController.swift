//
//  ViewController.swift
//  myjournal_lbta
//
//  Created by Jack Sp@rroW on 06.08.2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Posts"
        navigationItem.rightBarButtonItem = .init(title: "Creating posts", style: .plain, target: self, action: #selector(handleCreatePost))
        
    }

    
    @objc fileprivate func handleCreatePost() {
        print("creating post")
    }

}

