//
//  PayWallViewController.swift
//  Blog App
//
//  Created by Aurelio Le Clarke on 07.07.2022.
//

import UIKit

class PayWallViewController: UIViewController {

 
    
    
    private let header = PayWallHeaderView()
    //Header image
    private let headerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "crown.fill"))
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
        
        
    }()
    //Call to Action button, subscribe etc.
    private let buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Subscribe", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
        
    }()
    private let RestoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Restore Purchases", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(UIColor.link, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
        
    }()
    //  Pricing and product info
    //Terms of services
    
    private let termsView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textAlignment = .center
        textView.text = "This is auto renewable  Subscription"
        textView.font = .systemFont(ofSize: 14)
        
        return textView
        
    }()
    //Close button /Title
    private func setupCloseButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true,completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(header)
        view.addSubview(buyButton)
        view.addSubview(RestoreButton)
        setupCloseButton()
        setUpButtons()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.title = "Blog Premium"
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Palatino", size: 20)!]
        
      
    }
    
    private func setUpButtons() {
        buyButton.addTarget(self, action: #selector(didTapSubscribe), for: .touchUpInside)
        RestoreButton.addTarget(self, action: #selector(didTapRestore), for: .touchUpInside)
        
    }
    
    @objc private func didTapSubscribe() {
        //Revenue cat
        
    }
    @objc private func didTapRestore() {
        //Revenue cat
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        header.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height / 3.2)
    }

}
