//
//  CreateNewPostViewController.swift
//  Blog App
//
//  Created by Aurelio Le Clarke on 07.07.2022.
//

import UIKit

class CreateNewPostViewController: UITabBarController {

        //Title Field
    private let titleField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter title..."
       textField.backgroundColor = .secondarySystemBackground
        textField.autocorrectionType = .yes
        textField.autocapitalizationType = .words
      textField.leftViewMode = .always
       textField.layer.masksToBounds = true
        
      textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        
        return textField
    }()
    //Image header
    private let headerImageView: UIImageView = {
      let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        image.image = UIImage(systemName: "photo")
        image.backgroundColor = .tertiarySystemBackground
        
       
        return image
    }()
    
    
    //Text view for post
    private let textView: UITextView = {
        let text = UITextView()
        text.isEditable = true
        text.font = .systemFont(ofSize: 28, weight: .medium)
        text.backgroundColor = .systemBackground
        return text
    }()
    
    private func configureButtons() {
        navigationItem.leftBarButtonItem  = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem  = UIBarButtonItem(title: "Post", style: .done, target: self, action: #selector(didTapPost))
    }
    private var selectedHeaderImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        view.backgroundColor = .systemBackground
        view.addSubview(headerImageView)
        view.addSubview(textView)
        view.addSubview(titleField)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapHeader))
        
        headerImageView.addGestureRecognizer(tap)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleField.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: view.width-20, height: 50)
        headerImageView.frame = CGRect(x: 0, y: titleField.bottom+5, width: view.width, height: 160)
        textView.frame = CGRect(x: 10, y: headerImageView.bottom+10, width: view.width-20, height: view.height-210-view.safeAreaInsets.top)
    }
    
    
    @objc private func didTapHeader() {
        let  picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc private func didTapCancel() {
       dismiss(animated: true,completion: nil)
        
    }

    @objc private func didTapPost() {
        guard let title = titleField.text,
                let body  = textView.text,
              let email = UserDefaults.standard.string(forKey:"email"),
              let headerImage = selectedHeaderImage,
              !title.trimmingCharacters(in:.whitespaces).isEmpty,
              !body.trimmingCharacters(in:.whitespaces).isEmpty
                    
                else {
            let alert = UIAlertController(title: "Enter post detailes", message: "Please enter a title , body, select image to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Dissmiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return }
       
        let postID = UUID().uuidString
        
        //Upload header image
       
        StorageManager.shared.uploadBlogHeaderImage(email: email, image: headerImage,
                                                    postId:postID) { success in
            guard success else { return }
            
            StorageManager.shared.downloadUrlForPostHeader(email: email, postId: postID) { url in
                guard let headerUrl = url else {
                    print("failed to upload url for header")
                    return }
                //Insert post into Database
                
                let post =    BlogPost(
                              identifier:postID,
                              title:title,
                              timestamp: Date().timeIntervalSince1970,
                              HeaderImageURL: headerUrl,
                              text: body )
                DataBaseManager.shared.insert(blogPost: post, email: email) { [weak self] posted in
                    guard posted  else {
                        print("failed to post new blog article")
                        return }
                    
                    DispatchQueue.main.async {
                        self?.didTapCancel()
                    }
                }
            }
        }
        
        
    }
    
}
extension CreateNewPostViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true,completion: nil)
        guard let image = info[.originalImage] as? UIImage else { return }
        selectedHeaderImage = image
        headerImageView.image = image
    }
}

