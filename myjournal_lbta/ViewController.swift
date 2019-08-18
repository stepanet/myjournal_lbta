//
//  ViewController.swift
//  myjournal_lbta
//
//  Created by Jack Sp@rroW on 06.08.2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import UIKit

struct Post: Decodable {
    let id: Int
    let title, body: String
    let createdAt: Double
}

class Service: NSObject {
    static let shared = Service()
    
    func fetchPosts(completion: @escaping (Result<[Post], Error>) ->()) {
       
        guard let url = URL(string: "http://localhost:1337/posts") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            DispatchQueue.main.async {
                if let err = err {
                        print("failed to fetch posts:", err)
                        return
                    }
                    
                    guard let data = data else { return }
                    print(String(data: data, encoding: .utf8) ?? "")
                    
                    do {
                        let posts = try JSONDecoder().decode([Post].self, from: data)
                        completion(.success(posts))
                    } catch {
                        completion(.failure(error))
                    }
            }
            }.resume()
    }
}


class ViewController: UITableViewController {
    
    fileprivate func fetchPosts() {
        Service.shared.fetchPosts { (res) in
            switch res {
            case.failure(let err): print("failed to fetch posts:", err)
            case .success(let posts): print(posts)
            self.posts = posts
            self.tableView.reloadData()
            }
        }
    }
    
    var posts = [Post]()

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let post = posts[indexPath.row]
        let date = Date.init(timeIntervalSince1970: post.createdAt / 1000)
        cell.textLabel?.text = post.title + ":" + post.body
        cell.detailTextLabel?.text = "\(date)"
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        fetchPosts()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Posts"
        navigationItem.rightBarButtonItem = .init(title: "Creating posts", style: .plain, target: self, action: #selector(handleCreatePost))
        
    }

    
    @objc fileprivate func handleCreatePost() {
        print("creating post")
        fetchPosts() 
    }

}

