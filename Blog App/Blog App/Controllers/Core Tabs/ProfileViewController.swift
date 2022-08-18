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
    private var user: User?
    
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
        tableView.register(PostPreviewTableViewCell.self, forCellReuseIdentifier: PostPreviewTableViewCell.identifier)
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSignOutButton()
        view.backgroundColor = .systemBackground
        setUpTableHeader()
        setUpTable()
        fetchPosts()
        title = "Profile"
        
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
            self?.setUpTableHeader(profilePhotoRef: user.profilePictureRef, name: user.name)
        }
        
    }
    
   
    private func setUpTableHeader(profilePhotoRef: String? = nil,name: String? = nil) {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width))
        headerView.backgroundColor = .systemTeal
        headerView.isUserInteractionEnabled = true
        tableView.tableHeaderView = headerView
        tableView.clipsToBounds = true
        
        //Profile picture
        let profilePhoto = UIImageView(image: UIImage(systemName: "person.circle"))
        profilePhoto.tintColor = .white
        profilePhoto.contentMode = .scaleAspectFit
        
        
        profilePhoto.frame = CGRect(x: (view.width-(view.width/4))/2,
                                    y: (headerView.height-(view.width/6))/2.5,
                                    width: view.width/4,
                                    height: view.width/4)
        profilePhoto.layer.masksToBounds = true
        profilePhoto.layer.cornerRadius = profilePhoto.width/2
        profilePhoto.isUserInteractionEnabled = true
        headerView.addSubview(profilePhoto)
        let tap =  UITapGestureRecognizer(target: self, action: #selector(didTapProfilePhoto))
        profilePhoto.addGestureRecognizer(tap)
        //Name
        
        //Email
        let emailLabel = UILabel(frame: CGRect(x: 20, y: profilePhoto.bottom+10, width: view.width-40, height: 100))
        headerView.addSubview(emailLabel)
        emailLabel.text = currentEmail
        emailLabel.textAlignment = .center
        emailLabel.textColor = .white
        emailLabel.font = .systemFont(ofSize: 25, weight: .bold)
        
        if let name = name {
            title = name
            
        }
        if let ref = profilePhotoRef  {
            //FETCH IMAGE
            StorageManager.shared.downloadUrlForProfilePicture(path: ref) { url in
                guard let url = url else { return }
                let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                    guard let data = data else { return}
                    DispatchQueue.main.async {
                        profilePhoto.image = UIImage(data: data)
                    }
                }
                task.resume()
            }
       
        }
      
        
    }
    
    @objc private func didTapProfilePhoto() {
        guard let myEmail  = UserDefaults.standard.string(forKey: "email") else { return }
        guard myEmail == currentEmail else  { return }
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
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
    
    private var posts: [BlogPost] = []
    
    private func fetchPosts() {
        print("fetching posts...")
        DataBaseManager.shared.getPosts(for: currentEmail) { [weak self] posts in
            self?.posts = posts
            print("Found \(posts.count) posts")
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    //Table View
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostPreviewTableViewCell.identifier, for: indexPath) as?
                PostPreviewTableViewCell else  {
        fatalError("Error occured")  }
        
        cell.configure(with: .init(title: post.title, imageUrl:post.HeaderImageURL))

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ViewPostViewController(post: posts[indexPath.row])
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Post"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true,completion: nil)
        guard let image = info[.editedImage] as? UIImage else { return }
    
        StorageManager.shared.uploadUserProfile(email: currentEmail, image: image) { [ weak self] success in
            guard let strongSelf = self else { return }
            if success {
                //update database
                DataBaseManager.shared.updateProfilePhoto(email: strongSelf.currentEmail) { updated in
                    guard updated  else { return  }
                    DispatchQueue.main.async {
                        strongSelf.fetchProfileData()
                    }
                }
            }
        }
    }

}

