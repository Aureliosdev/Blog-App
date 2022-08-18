//
//  ViewPostViewController.swift
//  Blog App
//
//  Created by Aurelio Le Clarke on 07.07.2022.
//

import UIKit

class ViewPostViewController: UITabBarController,UITableViewDelegate,UITableViewDataSource {
   
    

    private let post: BlogPost
    
    
    init(post: BlogPost) {
        self.post = post
        super.init(nibName: nil, bundle: nil )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(PostHeaderTableViewCell.self, forCellReuseIdentifier: PostHeaderTableViewCell.identifier)
        
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        switch index {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = post.title
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = .systemFont(ofSize:  20,weight: .bold)
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostHeaderTableViewCell.identifier, for: indexPath) as? PostHeaderTableViewCell else { fatalError()}
         
             cell.configure(with: .init(imageUrl: post.HeaderImageURL))
             cell.selectionStyle = .none
             return cell
        case 2:
         
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = post.text
            cell.selectionStyle = .none
            cell.textLabel?.numberOfLines = 0
      
            return cell
        default:
            fatalError()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // title image and text
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let index = indexPath.row
        switch index {
        case 0:
            return 70
        case 1:
            return 150
           
        case 2:
            return UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }
}
