//
//  ProfileViewController.swift
//  Blog App
//
//  Created by Aurelio Le Clarke on 07.07.2022.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
 
    
    //  Profile photo
    
    //Full name
    
    //Email
    
    //List of posts
    
    let currentEmail: String
    
    init(currentEmail: String) {
        self.currentEmail = currentEmail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSignOutButton()
        view.backgroundColor = .systemBackground
        setUpTableHeader()
        setUpTable()
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    private func setUpSignOutButton() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(didTapSignOut))
    }
    private func setUpTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        setUpTableHeader()
        fetchProfileData()
    }
    
    
    private func  fetchProfileData() {
        DataBaseManager.shared.getUser(email: currentEmail) { [weak self] user in
            guard let user = user  else  { return }
        }
        
    }
    private func setUpTableHeader(profilePhotoURL: URL? = nil,name: String? = nil) {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width))
        headerView.backgroundColor = .systemBlue
        tableView.tableHeaderView = headerView
        tableView.clipsToBounds = true
        
        //Profile picture
        let profilePhoto = UIImageView(image: UIImage(systemName: "person"))
        profilePhoto.tintColor = .white
        profilePhoto.contentMode = .scaleAspectFit
        profilePhoto.frame = CGRect(x: (view.width-(view.width/4))/2,
                                    y: (headerView.height-(view.width/4))/2.5,
                                    width: view.width/4,
                                    height: view.width/4)
        headerView.addSubview(profilePhoto)
        //Name
        
        //Email
        let emailLabel = UILabel(frame: CGRect(x: 20, y: profilePhoto.bottom+30, width: view.width-40, height: 100))
        headerView.addSubview(emailLabel)
        emailLabel.text = currentEmail
        emailLabel.textAlignment = .center
        emailLabel.font = .systemFont(ofSize: 25, weight: .bold)
        
        if let name = name {
            title = name
            
        }
        if let url = profilePhotoURL {
            //FETCH IMAGE
            
        }
    }
    //Sign out function
    @objc private func didTapSignOut() {
        let sheet  = UIAlertController(title: "Sign Out", message: "Are you sure?", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
            AuthManager.shared.signOut { [weak self] success in
                if success{
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(nil, forKey: "email")
                        UserDefaults.standard.set(nil, forKey: "name")
                        let SignInVC = SignInViewController()
                        SignInVC.navigationItem.largeTitleDisplayMode = .always
                        let NavVc = UINavigationController(rootViewController: SignInVC)
                        NavVc.navigationBar.prefersLargeTitles = true
                        NavVc.modalPresentationStyle = .fullScreen
                        self?.present(NavVc,animated: true,completion: nil)
                    }
                }
            }
        }))
        present(sheet,animated: true)
        
    }
    
    //Table View
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Title"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
}
