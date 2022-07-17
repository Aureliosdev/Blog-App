//
//  ViewController.swift
//  testing UIView
//
//  Created by Aurelio Le Clarke on 17.07.2022.
//

import UIKit

class ViewController: UIViewController {

    
 
    
    private let keyButton: UIButton = {
        let button = UIButton()
        button.setTitle("PressMe", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        
        return button
        
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(keyButton)
   
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        keyButton.frame = CGRect(x: 100, y:150, width: 200, height: 50)

}

}
