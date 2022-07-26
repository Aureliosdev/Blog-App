//
//  SignInViewController.swift
//  Blog App
//
//  Created by Aurelio Le Clarke on 07.07.2022.
//

import UIKit

class SignInViewController: UITabBarController {

    //Header View
    private let headerView = SignInHeaderView()
    
    //Email field
    
    private let emailField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.keyboardType = .emailAddress
        emailTextField.placeholder = "Email Adress"
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
        passwordField.leftViewMode = .always
        passwordField.isSecureTextEntry = true
        passwordField.layer.cornerRadius = 8
        passwordField.layer.masksToBounds = true
        
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        
        return passwordField
        
    }()
    //Sign in button
    private let signInButton: UIButton =  {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    //Create Account
    private let CreateAccButton: UIButton =  {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.link, for: .normal)
    
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
                title = " Sign In"
        view.addSubview(headerView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(CreateAccButton)
      
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        CreateAccButton.addTarget(self, action: #selector(didTapCreate), for: .touchUpInside)
        
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height/5)
        emailField.frame = CGRect(x: 20, y: headerView.bottom, width: view.width-40, height: 50)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom+10, width: view.width-40, height: 50)
        signInButton.frame = CGRect(x: 20, y: passwordField.bottom+10   , width: view.width-40, height: 50)
        CreateAccButton.frame = CGRect(x: 20, y: signInButton.bottom+40, width: view.width-40, height: 50)
  
    }

    @objc func didTapSignIn() {
        
        
    }
    @objc func didTapCreate() {
        let vc = SignUpViewController()
        vc.title = " Create Account"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
