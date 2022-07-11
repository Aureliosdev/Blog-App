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
    //  Pricing and product info
    //Terms of services
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
        view.backgroundColor = .systemBackground
        setupCloseButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        header.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height / 3.2)
    }

}
