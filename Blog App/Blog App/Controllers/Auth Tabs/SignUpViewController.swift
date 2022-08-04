//
//  SignUpViewController.swift
//  Blog App
//
//  Created by Aurelio Le Clarke on 07.07.2022.
//

import UIKit

class SignUpViewController: UITabBarController {

    //Header View
    private let headerView = SignInHeaderView()
    
    //Name field
    private let nameField: UITextField = {
        let nameTextField = UITextField()
       
        nameTextField.placeholder = "Your Name"
        nameTextField.backgroundColor = .secondarySystemBackground
        nameTextField.leftViewMode = .always
        nameTextField.layer.cornerRadius = 8
        nameTextField.layer.masksToBounds = true
        
        nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        
        return nameTextField
    }()
    //Email field
    
    private let emailField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.keyboardType = .emailAddress
        emailTextField.placeholder = "Email Adress"
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.backgroundColor = .secondarySystemBackground
        emailTextField.leftViewMode = .always
        emailTextField.layer.cornerRadius = 8
        emailTextField.layer.masksToBounds = true
        
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        
        return emailTextField
    }()
    //password field
    private let passwordField: UITextField = {
        let passwordField = UITextField()
        passwordField.keyboardType = .emailAddress
        passwordField.placeholder = "Password"
        passwordField.backgroundColor = .secondarySystemBackground
        passwordField.autocorrectionType = .no
        passwordField.autocapitalizationType = .none
        passwordField.leftViewMode = .always
        passwordField.isSecureTextEntry = true
        passwordField.layer.cornerRadius = 8
        passwordField.layer.masksToBounds = true
        
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        
        return passwordField
        
    }()
    //Sign in button
    private let signUpButton: UIButton =  {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
  

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
                title = "Create Account"
        view.addSubview(headerView)
        view.addSubview(nameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signUpButton)
       
      
         
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            if !IAPManager.shared.isPremium() {
                let vc = PayWallViewController()
                let navVC = UINavigationController(rootViewController: vc)
                self.present(navVC,animated: true,completion: nil)
               
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height/5)
        nameField.frame = CGRect(x: 20, y: headerView.bottom, width: view.width-40, height: 50)
        emailField.frame = CGRect(x: 20, y: nameField.bottom+10, width: view.width-40, height: 50)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom+10, width: view.width-40, height: 50)
        signUpButton.frame = CGRect(x: 20, y: passwordField.bottom+10   , width: view.width-40, height: 50)
            
  
    }

    @objc func didTapSignUp() {
        guard let email = emailField.text , !email.isEmpty,
              let password  = passwordField.text , !password.isEmpty,
              let name = nameField.text, !name.isEmpty else { return }
        
        
        //Create User
        AuthManager.shared.signUp(email: email, password: password) { [weak self] success in
            if  success  {
                // update database
                let newUser = User(name: name, email: email, profilePictureURL: nil)
                DataBaseManager.shared.insert(user: newUser) { inserted in
                    guard inserted else { return }
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(name, forKey: "name")
                    
                    DispatchQueue.main.async {
                        let vc = TabBarController()
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc,animated: true)
                    }
                }
            }else  {
                print("Failed to create account")
            }
        }
        
        //Update Database
    
    }
   
    

    

}
